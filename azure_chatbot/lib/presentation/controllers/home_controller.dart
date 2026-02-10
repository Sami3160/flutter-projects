import 'package:azure_chatbot/app/core/base/base_controller.dart';
import 'package:azure_chatbot/app/services/speech_service.dart';
import 'package:azure_chatbot/app/services/tts_service.dart';
import 'package:azure_chatbot/domain/entities/conversation_history.dart';
import 'package:azure_chatbot/domain/usecase/get_ai_response_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Message model for chat display
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();
}

class HomeController extends BaseController {
  final GetAiResponseUsecase _usecase;

  HomeController(this._usecase);

  // Services
  final TtsService _ttsService = Get.find<TtsService>();
  final SpeechService _speechService = Get.find<SpeechService>();

  // Text controller for manual input
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  // mic state listening | idle
  final RxString micState = 'idle'.obs;
  // speaker state answering | idle
  final RxString speakerState = 'idle'.obs;

  // Observable states
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxList<ConversationHistory> conversationHistory =
      <ConversationHistory>[].obs;
  final RxBool isRecording = false.obs;
  final RxBool isProcessing = false.obs;
  final RxBool isSpeaking = false.obs;
  final RxString currentTranscript = ''.obs;
  final RxString errorMessage = ''.obs;
  final RxString inputText = ''.obs;

  // Getters for service states
  bool get isTtsReady => _ttsService.isInitialized.value;
  bool get isSpeechReady => _speechService.isInitialized.value;

  @override
  void onInit() {
    super.onInit();

    // Listen to text controller changes
    textController.addListener(() {
      inputText.value = textController.text;
    });

    // Bind to service states
    ever(_speechService.recognizedText, (text) {
      currentTranscript.value = text;
    });

    ever(_speechService.isListening, (listening) {
      isRecording.value = listening;
    });

    ever(_ttsService.isSpeaking, (speaking) {
      isSpeaking.value = speaking;
    });
  }

  /// Start voice recording
  Future<void> startRecording() async {
    if (!_speechService.isInitialized.value) {
      errorMessage.value = 'Speech recognition not available';
      return;
    }

    if (_ttsService.isSpeaking.value) {
      await _ttsService.stop();
    }

    // Cancel any in-progress speech session first
    if (_speechService.isListening.value) {
      await _speechService.cancelListening();
    }

    // Small delay to let the recognizer fully clean up
    await Future.delayed(const Duration(milliseconds: 300));

    currentTranscript.value = '';
    errorMessage.value = '';

    await _speechService.startListening(
      onResult: (text) {
        if (text.isNotEmpty) {
          sendMessage(text);
        }
      },
    );
  }

  /// Stop voice recording
  Future<void> stopRecording() async {
    await _speechService.stopListening();
  }

  /// Toggle recording state
  Future<void> toggleRecording() async {
    if (isRecording.value) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }

  /// Send a message (either from voice or text input)
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = text.trim();

    // Add user message to chat
    messages.add(ChatMessage(text: userMessage, isUser: true));

    // Clear text input
    currentTranscript.value = '';

    // Scroll to bottom
    _scrollToBottom();

    // Set processing state
    isProcessing.value = true;
    errorMessage.value = '';

    try {
      // Get AI response
      final response = await _usecase.execute(
        GetAiResponseParams(
          message: userMessage,
          conversation_history: conversationHistory.toList(),
        ),
      );

      // Add to conversation history
      conversationHistory.add(
        ConversationHistory(role: 'user', content: userMessage),
      );
      conversationHistory.add(
        ConversationHistory(role: 'assistant', content: response),
      );

      // Add AI response to chat
      messages.add(ChatMessage(text: response, isUser: false));

      // Scroll to bottom
      _scrollToBottom();

      // Speak the response
      if (_ttsService.isInitialized.value) {
        await _ttsService.speak(response);
      }
    } catch (e) {
      errorMessage.value = 'Failed to get response: ${e.toString()}';
      messages.add(
        ChatMessage(
          text: 'Sorry, I encountered an error. Please try again.',
          isUser: false,
        ),
      );
    } finally {
      isProcessing.value = false;
    }
  }

  /// Send message from text field
  void sendTextMessage() {
    sendMessage(textController.text);
  }

  /// Stop current speech
  Future<void> stopSpeaking() async {
    await _ttsService.stop();
  }

  /// Clear conversation history
  void clearConversation() {
    messages.clear();
    conversationHistory.clear();
    errorMessage.value = '';
  }

  /// Scroll chat to bottom
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

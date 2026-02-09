import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

/// Service for handling Speech-to-Text operations
class SpeechService extends GetxService {
  final SpeechToText _speechToText = SpeechToText();

  final RxBool isInitialized = false.obs;
  final RxBool isListening = false.obs;
  final RxString recognizedText = ''.obs;
  final RxString lastError = ''.obs;
  final RxDouble soundLevel = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    try {
      isInitialized.value = await _speechToText.initialize(
        onError: (error) {
          lastError.value = error.errorMsg;
          isListening.value = false;
          print('Speech recognition error: ${error.errorMsg}');
        },
        onStatus: (status) {
          print('Speech recognition status: $status');
          if (status == 'done' || status == 'notListening') {
            isListening.value = false;
          }
        },
      );

      if (isInitialized.value) {
        print('Speech recognition initialized successfully');
      } else {
        print('Speech recognition not available on this device');
      }
    } catch (e) {
      print('Error initializing speech: $e');
      isInitialized.value = false;
    }
  }

  /// Start listening for speech input
  Future<void> startListening({
    Function(String)? onResult,
    Function()? onDone,
  }) async {
    if (!isInitialized.value) {
      print('Speech recognition not initialized');
      return;
    }

    if (isListening.value) {
      print('Already listening');
      return;
    }

    recognizedText.value = '';
    lastError.value = '';
    isListening.value = true;

    await _speechToText.listen(
      onResult: (SpeechRecognitionResult result) {
        recognizedText.value = result.recognizedWords;

        if (result.finalResult) {
          isListening.value = false;
          onResult?.call(result.recognizedWords);
          onDone?.call();
        }
      },
      onSoundLevelChange: (level) {
        soundLevel.value = level;
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      cancelOnError: true,
      listenMode: ListenMode.dictation,
    );
  }

  /// Stop listening
  Future<void> stopListening() async {
    if (!isListening.value) return;

    await _speechToText.stop();
    isListening.value = false;
  }

  /// Cancel listening
  Future<void> cancelListening() async {
    await _speechToText.cancel();
    isListening.value = false;
    recognizedText.value = '';
  }

  /// Check if speech recognition is available
  bool get isAvailable => isInitialized.value;

  /// Get list of available locales
  Future<List<LocaleName>> getAvailableLocales() async {
    if (!isInitialized.value) return [];
    return await _speechToText.locales();
  }

  @override
  void onClose() {
    _speechToText.cancel();
    super.onClose();
  }
}

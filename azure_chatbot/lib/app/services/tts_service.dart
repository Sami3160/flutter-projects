import 'dart:io';
import 'package:flutter_azure_tts/flutter_azure_tts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

/// Service for handling Azure Text-to-Speech operations
class TtsService extends GetxService {
  late AudioPlayer _audioPlayer;
  Voice? _selectedVoice;

  final RxBool isInitialized = false.obs;
  final RxBool isSpeaking = false.obs;
  final RxString currentVoiceName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    try {
      final subscriptionKey = dotenv.env['AZURE_SUBSCRIPTION_KEY'] ?? '';
      final region = dotenv.env['AZURE_REGION'] ?? '';

      if (subscriptionKey.isEmpty || region.isEmpty) {
        print('Azure TTS credentials not found in .env file');
        return;
      }

      // Initialize Azure TTS
      FlutterAzureTts.init(
        subscriptionKey: subscriptionKey,
        region: region,
        withLogs: true,
        retryPolicy: RetryPolicy(
          maxRetries: 3,
          baseDelay: Duration(milliseconds: 500),
          maxDelay: Duration(seconds: 10),
        ),
        requestTimeout: Duration(seconds: 30),
      );

      // Get and select a default voice
      await _selectDefaultVoice();
      isInitialized.value = true;
      print('Azure TTS initialized successfully');
    } catch (e) {
      print('Error initializing TTS: $e');
    }
  }

  Future<void> _selectDefaultVoice() async {
    try {
      final voicesResponse = await FlutterAzureTts.getAvailableVoices();

      // Try to find a neural English US voice
      final filteredVoices = voicesResponse.voices
          .filter()
          .byLocale('en-US')
          .neural()
          .results;

      if (filteredVoices.isNotEmpty) {
        _selectedVoice = filteredVoices.first;
        currentVoiceName.value = _selectedVoice!.displayName;
        print('Selected voice: ${_selectedVoice!.displayName}');
      }
    } catch (e) {
      print('Error selecting voice: $e');
    }
  }

  /// Speak the given text using Azure TTS
  Future<void> speak(String text) async {
    if (!isInitialized.value || _selectedVoice == null) {
      print('TTS not initialized or no voice selected');
      return;
    }

    if (text.isEmpty) {
      print('No text to speak');
      return;
    }

    try {
      isSpeaking.value = true;

      // Build TTS parameters
      final params = TtsParamsBuilder()
          .voice(_selectedVoice!)
          .text(text)
          .audioFormat(AudioOutputFormat.audio16khz32kBitrateMonoMp3)
          .rate(1.0) // Normal speed
          .build();

      // Generate audio
      final audioResponse = await FlutterAzureTts.getTts(params);
      final audioBytes = audioResponse.audio;

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final audioFile = File('${tempDir.path}/tts_output.mp3');
      await audioFile.writeAsBytes(audioBytes);

      // Play the audio
      await _audioPlayer.setFilePath(audioFile.path);
      await _audioPlayer.play();

      // Wait for playback to complete
      await _audioPlayer.playerStateStream.firstWhere(
        (state) => state.processingState == ProcessingState.completed,
      );
    } catch (e) {
      print('Error speaking text: $e');
    } finally {
      isSpeaking.value = false;
    }
  }

  /// Stop current speech
  Future<void> stop() async {
    await _audioPlayer.stop();
    isSpeaking.value = false;
  }

  /// Set a custom voice by locale
  Future<void> setVoiceByLocale(String locale) async {
    try {
      final voicesResponse = await FlutterAzureTts.getAvailableVoices();
      final filteredVoices = voicesResponse.voices
          .filter()
          .byLocale(locale)
          .neural()
          .results;

      if (filteredVoices.isNotEmpty) {
        _selectedVoice = filteredVoices.first;
        currentVoiceName.value = _selectedVoice!.displayName;
      }
    } catch (e) {
      print('Error setting voice: $e');
    }
  }

  /// Get list of available voices
  Future<List<Voice>> getAvailableVoices() async {
    try {
      final voicesResponse = await FlutterAzureTts.getAvailableVoices();
      return voicesResponse.voices.toList();
    } catch (e) {
      print('Error getting voices: $e');
      return [];
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}

import 'dart:io';
import 'package:azure_chatbot/data/providers/network/api_endpoints.dart';
import 'package:azure_chatbot/data/providers/network/api_provider.dart';
import 'package:azure_chatbot/data/providers/network/api_request_representable.dart';
import 'package:azure_chatbot/domain/entities/conversation_history.dart';


class AiApi implements APIRequestRepresentable {
  final String? message;
  final List<ConversationHistory>? conversationHistory;
  final String? systemPrompt;

  AiApi._({
    required this.message,
    this.conversationHistory,
    this.systemPrompt,
  });

  factory AiApi.chat({
    required String message,
    required List<ConversationHistory> conversationHistory,
    String systemPrompt =
        "You are a helpful assistant. Just answer the question.",
  }) {
    return AiApi._(
      message: message,
      conversationHistory: conversationHistory,
      systemPrompt: systemPrompt,
    );
  }

  @override
  String get endpoint => ApiEndpoints.baseUrl;

  @override
  String get path =>"/ai/chat";

  @override
  HTTPMethod get method =>HTTPMethod.post;

  @override
  Map<String, String>? get headers {
    return {HttpHeaders.contentTypeHeader: 'application/json'};
  }

  @override
  Map<String, String>? get query {
    return null;
  }

  @override
  dynamic get body {
    return {
      "message": message,
      "conversation_history": conversationHistory
          ?.map((h) => h.toJson())
          .toList(),
      "system_prompt": systemPrompt,
    };
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}

import 'dart:io';
import 'package:azure_chatbot/data/providers/network/api_endpoints.dart';
import 'package:azure_chatbot/data/providers/network/api_provider.dart';
import 'package:azure_chatbot/data/providers/network/api_request_representable.dart';

enum AuthType { login, logout, signin, profile   }

class AuthAPI implements APIRequestRepresentable {
  final AuthType type;
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  String? email;

  AuthAPI._({
    required this.type,
    this.password,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
  });

  AuthAPI.login({required String email, required String password})
    : this._(type: AuthType.login, email: email, password: password);
  AuthAPI.signin(
    String firstName,
    String lastName,
    String email,
    String password,
  ) : this._(
        type: AuthType.signin,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
  AuthAPI.profile():this._(type: AuthType.profile);

  @override
  String get endpoint => ApiEndpoints.baseUrl;

  @override
  String get path {
    switch (type) {
      case AuthType.signin:
        return "/users/register";
      case AuthType.login:
        return "/users/login";

      case AuthType.profile:
        return "/users/profile";
      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case AuthType.profile:
        return HTTPMethod.get;
      default:
        return HTTPMethod.post;
    }
  }

  @override
  Map<String, String> get headers => {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  @override
  Map<String, String>? get query {
    return null;
  }

  @override
  get body {
    switch (type) {
      case AuthType.login:
        return {"email": email, "password": password};
      case AuthType.signin:
        return {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
        };
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}

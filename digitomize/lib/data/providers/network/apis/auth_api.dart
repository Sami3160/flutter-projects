import 'dart:io';
import 'package:digitomize/data/providers/network/api_endpoints.dart';
import 'package:digitomize/data/providers/network/api_provider.dart';
import 'package:digitomize/data/providers/network/api_request_representable.dart';

enum AuthType { login, logout, signin }

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

  AuthAPI.login(String username, String repo) : this._(type: AuthType.login);
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
  AuthAPI.register(String password, String username)
      : this._(type: AuthType.login, username: username, password: password);

  @override
  String get endpoint => ApiEndpoints.baseUrl;

  String get path {
    switch (type) {
      case AuthType.signin:
        return "/users/register";
      case AuthType.login:
        return "/users/login";
      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  Map<String, String> get headers =>
      {HttpHeaders.contentTypeHeader: 'application/json'};

  Map<String, String> get query {
    return {HttpHeaders.contentTypeHeader: 'application/json'};
  }

  @override
  get body => null;

  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
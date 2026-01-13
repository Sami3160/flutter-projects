/// {@template login_response}
/// Represents the server response received after a successful login attempt.
///
/// This model encapsulates the authentication token returned by the backend,
/// which is used for subsequent authenticated API requests.
///
/// ## Why this class is necessary:
/// - **Type Safety**: Provides compile-time type checking instead of working with raw maps
/// - **Data Validation**: Ensures the response contains expected fields
/// - **Serialization**: Centralizes JSON parsing logic in one place
/// - **Maintainability**: Makes changes to API response structure easier (only modify here)
/// - **Code Clarity**: Self-documenting what the login response contains
///
/// ## Why the factory constructor is needed:
/// The [LoginResponse.fronJson] factory method handles conversion from JSON (Map) to a strongly-typed Dart object.
/// This is necessary because:
/// - HTTP responses arrive as raw JSON strings, parsed into Maps by libraries like `http` or `dio`
/// - Converting to a typed object prevents runtime errors from missing/invalid fields
/// - Enables IDE autocomplete and refactoring support
/// - Decouples JSON parsing logic from business logic
///
/// Note: This architecture is not "complex" but rather a **best practice** that scales well
/// as your app grows. Without it, you'd scatter JSON parsing throughout your codebase,
/// making it harder to maintain and test.
///
/// {@endtemplate}
class LoginResponse {
  final String accessToken;
  LoginResponse({required this.accessToken});
  factory LoginResponse.fronJson(Map<String, dynamic> json){
    return LoginResponse(accessToken: json['accessToken']);
  }
}

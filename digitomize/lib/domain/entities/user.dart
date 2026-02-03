class User {
  User({
    required this.id,
    required this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.accessToken,
    this.refreshToken,
    this.address,
    this.institute,
    this.bio,
    this.lcUsername,
    this.profileUrl
  });

  String id;
  String username;
  String? email;
  String? firstName;
  String? lastName;
  String? accessToken;
  String? refreshToken;
  String? address;
  String? institute;
  String? bio;
  String? lcUsername;
  String? profileUrl;

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return User(id: '', username: 'Guest');
    }

    // Handle case where user data might be nested under a 'user' key
    final Map<String, dynamic> data =
        json.containsKey('user') && json['user'] is Map<String, dynamic>
        ? json['user'] as Map<String, dynamic>
        : json;

    return User(
      // Use ?? to provide defaults if keys are missing or null,
      // and handle both 'id' and '_id' common in MongoDB backends
      id: (data['id'] ?? data['_id'] ?? '').toString(),
      username: (data['username'] ?? '').toString(),
      email: data['email']?.toString() ?? '',
      firstName: data['firstName']?.toString() ?? '',
      lastName: data['lastName']?.toString() ?? '',
      // AccessToken might be in the root response if 'user' was a nested key
      accessToken: (json['token'] ?? data['accessToken'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? data['refreshToken'] ?? '')
          .toString(),
      address: data['address']?.toString() ?? '',
      institute: data['institute']?.toString() ?? '',
      bio: data['bio']?.toString() ?? '',
      lcUsername: data['lcUsername']?.toString() ?? '',
      profileUrl: data['profileUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'address': address,
    'institute': institute,
    'bio': bio,
    'lcUsername': lcUsername,
    'profileUrl': profileUrl,
  };
}

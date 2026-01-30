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

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id:json?['id'] as String,
      username: json?['username'] as String ,
      email: json?['email'] as String? ?? '',
      firstName: json?['firstName'] as String? ?? '',
      lastName: json?['lastName'] as String? ?? '',
      accessToken: json?['accessToken'] as String? ?? '',
      refreshToken: json?['refreshToken'] as String? ?? '',
      address: json?['address'] as String? ?? '',
      institute: json?['institute'] as String? ?? '',
      bio: json?['bio'] as String? ?? '',
      lcUsername: json?['lcUsername'] as String? ?? '',
    
    );
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'username':username,
    'email':email,
    'firstName':firstName,
    'lastName':lastName,  
    'accessToken':accessToken,
    'refreshToken':refreshToken,
    'address':address,
    'institute':institute,
    'bio':bio,
    'lcUsername':lcUsername,
  };
}

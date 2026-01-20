class User {
  User({
    required this.id,
    required this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.accessToken,
    this.refreshToken,
  });

  int id;
  String username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? accessToken;
  String? refreshToken;

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id:json?['id'] as int,
      username: json?['username'] as String ,
      email: json?['email'] as String? ?? '',
      firstName: json?['firstName'] as String? ?? '',
      lastName: json?['lastName'] as String? ?? '',
      gender: json?['gender'] as String? ?? '',
      image: json?['image'] as String? ?? '',
      accessToken: json?['accessToken'] as String? ?? '',
    
    );
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'username':username,
    'email':email,
    'firstName':firstName,
    'lastName':lastName,
    'gender':gender,
    'image':image,
  };
}

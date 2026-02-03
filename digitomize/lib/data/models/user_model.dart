import 'package:json_annotation/json_annotation.dart';
import 'package:digitomize/domain/entities/user.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel({
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
  }) : super(
         id: id,
         username: username,
         email: email,
         firstName: firstName,
         lastName: lastName,
         accessToken: accessToken,
         refreshToken: refreshToken,
         address: address,
         institute: institute,
         bio: bio,
         lcUsername: lcUsername,
         profileUrl: profileUrl,
       );

  @override
  String id;
  @override
  String username;
  @override
  String? email;
  @override
  String? firstName;
  @override
  String? lastName;
  @override
  String? accessToken;
  @override
  String? refreshToken;
  @override
  String? address;
  @override
  String? institute;
  @override
  String? bio;
  @override
  String? lcUsername;
  @override
  String? profileUrl;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

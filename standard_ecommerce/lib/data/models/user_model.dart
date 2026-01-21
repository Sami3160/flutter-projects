import 'package:json_annotation/json_annotation.dart';
import 'package:standard_ecommerce/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User{
  UserModel({
    required this.id,
    required this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.accessToken,
    this.refreshToken,
  }) : super(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    gender: gender,
    image: image,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );

  @override
  int id;
  @override
  String username;
  @override
  String? email;
  @override
  String? firstName;
  @override
  String? lastName;
  @override
  String? gender;
  @override
  String? image;
  @override
  String? accessToken;
  @override
  String? refreshToken;


  factory UserModel.fromJson(Map<String, dynamic> json)=>_$UserModelFromJson(json);
    @override
  Map<String, dynamic > toJson()=>_$UserModelToJson(this);
}
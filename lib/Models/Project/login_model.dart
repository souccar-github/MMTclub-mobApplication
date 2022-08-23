import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String userNameOrEmailAddress;
  String password;
  String fcmToken;

  LoginModel(this.userNameOrEmailAddress, this.password, this.fcmToken);

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

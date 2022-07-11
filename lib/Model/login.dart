import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

// **************************************************************
// Login model data send to make login or signUp within the app
// **************************************************************

@JsonSerializable()
class Login {
  String? email;
  String? password;
  String? name;


  Login({
    this.email,
    this.password,
    this.name
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Object {
  @JsonKey(name: 'info')
  InfoLoginInput info;

  @JsonKey(name: 'version')
  String version;

  LoginModel(this.info, this.version);

  factory LoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class InfoLoginInput extends Object {
  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'password')
  String password;

  InfoLoginInput(
    this.username,
    this.password,
  );

  factory InfoLoginInput.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoLoginInputFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoLoginInputToJson(this);
}

@JsonSerializable()
class LoginResponseModel extends Object {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'result_code')
  String resultCode;

  @JsonKey(name: 'result_description')
  String resultDescription;

  LoginResponseModel(
    this.message,
    this.resultCode,
    this.resultDescription,
  );

  factory LoginResponseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginResponseModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

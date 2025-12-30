import 'user_model.dart';

class LoginResponseModel {
  final bool success;
  final String message;
  final LoginResponseData? data;

  LoginResponseModel({required this.success, required this.message, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? LoginResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class LoginResponseData {
  final UserModel? user;
  final String? token;

  LoginResponseData({this.user, this.token});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}

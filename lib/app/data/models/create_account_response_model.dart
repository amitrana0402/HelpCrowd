import 'user_model.dart';

class CreateAccountResponseModel {
  final bool success;
  final String message;
  final CreateAccountResponseData? data;

  CreateAccountResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CreateAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? CreateAccountResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class CreateAccountResponseData {
  final UserModel? user;
  final String? token;

  CreateAccountResponseData({
    this.user,
    this.token,
  });

  factory CreateAccountResponseData.fromJson(Map<String, dynamic> json) {
    return CreateAccountResponseData(
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : null,
      token: json['token'],
    );
  }
}


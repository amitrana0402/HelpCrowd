class SignupResponseModel {
  final bool success;
  final String message;
  final SignupResponseData? data;

  SignupResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? SignupResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class SignupResponseData {
  final String email;

  SignupResponseData({
    required this.email,
  });

  factory SignupResponseData.fromJson(Map<String, dynamic> json) {
    return SignupResponseData(
      email: json['email'] ?? '',
    );
  }
}


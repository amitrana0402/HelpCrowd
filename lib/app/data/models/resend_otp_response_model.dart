class ResendOtpResponseModel {
  final bool success;
  final String message;
  final ResendOtpResponseData? data;

  ResendOtpResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? ResendOtpResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class ResendOtpResponseData {
  final String email;

  ResendOtpResponseData({
    required this.email,
  });

  factory ResendOtpResponseData.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponseData(
      email: json['email'] ?? '',
    );
  }
}


class VerifyOtpResponseModel {
  final bool success;
  final String message;
  final VerifyOtpResponseData? data;

  VerifyOtpResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? VerifyOtpResponseData.fromJson(json['data'])
          : null,
    );
  }
}

class VerifyOtpResponseData {
  final String email;

  VerifyOtpResponseData({
    required this.email,
  });

  factory VerifyOtpResponseData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseData(
      email: json['email'] ?? '',
    );
  }
}


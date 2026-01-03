class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl = 'https://helpcrowd.cso9.com/api';

  // Auth Endpoints
  static const String signup = '/auth/signup';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String createAccount = '/auth/create-account';
  static const String login = '/auth/login';

  // Profile Endpoints
  // static const String profile = '/user/profile'; // Profile API endpoint (not available yet)

  // Settings Endpoints
  static const String checkUsername = '/settings/username/check';
  static const String setUsername = '/settings/username';
}

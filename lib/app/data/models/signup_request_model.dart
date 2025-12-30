class SignupRequestModel {
  final String firstname;
  final String lastname;
  final String email;
  final String mobile;
  final String password;
  final String passwordConfirmation;

  SignupRequestModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.mobile,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'mobile': mobile,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}


class CreateAccountRequestModel {
  final String email;

  CreateAccountRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}


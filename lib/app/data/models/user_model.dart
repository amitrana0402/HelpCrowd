class UserModel {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? mobile;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      email: json['email'],
      firstName: json['first_name'] ?? json['firstName'],
      lastName: json['last_name'] ?? json['lastName'],
      username: json['username'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'mobile': mobile,
    };
  }
}


class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final int? impersonatingCharityId;
  final int? originalUserId;
  final bool? isSuperAdmin;
  final int? referredByCharityId;
  final String? emailVerifiedAt;
  final String? twoFactorConfirmedAt;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.impersonatingCharityId,
    this.originalUserId,
    this.isSuperAdmin,
    this.referredByCharityId,
    this.emailVerifiedAt,
    this.twoFactorConfirmedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int
          ? json['id']
          : (json['id'] != null ? int.tryParse(json['id'].toString()) : null),
      name: json['name'],
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      impersonatingCharityId: json['impersonating_charity_id'] is int
          ? json['impersonating_charity_id']
          : (json['impersonating_charity_id'] != null
                ? int.tryParse(json['impersonating_charity_id'].toString())
                : null),
      originalUserId: json['original_user_id'] is int
          ? json['original_user_id']
          : (json['original_user_id'] != null
                ? int.tryParse(json['original_user_id'].toString())
                : null),
      isSuperAdmin: json['is_super_admin'] ?? false,
      referredByCharityId: json['referred_by_charity_id'] is int
          ? json['referred_by_charity_id']
          : (json['referred_by_charity_id'] != null
                ? int.tryParse(json['referred_by_charity_id'].toString())
                : null),
      emailVerifiedAt: json['email_verified_at'],
      twoFactorConfirmedAt: json['two_factor_confirmed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'phone': phone,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
      'impersonating_charity_id': impersonatingCharityId,
      'original_user_id': originalUserId,
      'is_super_admin': isSuperAdmin,
      'referred_by_charity_id': referredByCharityId,
      'email_verified_at': emailVerifiedAt,
      'two_factor_confirmed_at': twoFactorConfirmedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

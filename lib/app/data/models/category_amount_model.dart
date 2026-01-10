import 'package:flutter/material.dart';

class CategoryAmountModel {
  final String id;
  final String title;
  final String icon;
  final String? description;
  final double? amount;

  CategoryAmountModel({
    required this.id,
    required this.title,
    required this.icon,
    this.description,
    this.amount,
  });

  factory CategoryAmountModel.fromJson(Map<String, dynamic> json) {
    return CategoryAmountModel(
      id: json['id']?.toString() ?? '',
      title: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'],
      amount: json['specify_amount'] != null
          ? double.tryParse(json['specify_amount'].toString())
          : null,
    );
  }

  CategoryAmountModel copyWith({
    String? id,
    String? title,
    String? icon,
    String? description,
    double? amount,
  }) {
    return CategoryAmountModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      amount: amount ?? this.amount,
    );
  }

  String get formattedAmount {
    if (amount == null) return '';
    return '+ \$${amount!.toStringAsFixed(2)}';
  }
}


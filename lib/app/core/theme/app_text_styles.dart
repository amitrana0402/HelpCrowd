import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Heading Styles
  static TextStyle get h1 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle get h1Light => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    height: 1.2,
  );

  static TextStyle get h2 => const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get h2Light => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    height: 1.3,
  );

  static TextStyle get h3 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get h3Light => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
    height: 1.3,
  );

  // Body Styles
  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyLargeLight => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.5,
  );

  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodyMediumLight => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.5,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle get bodySmallLight => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.5,
  );

  // Button Text
  static TextStyle get buttonText => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonTextPrimary,
    height: 1.2,
  );

  static TextStyle get buttonTextSecondary => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonTextSecondary,
    height: 1.2,
  );

  // Caption Styles
  static TextStyle get caption => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get captionLight => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.4,
  );

  // Link Styles
  static TextStyle get link => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.linkColor,
    decoration: TextDecoration.underline,
    height: 1.5,
  );

  // Subtitle Styles
  static TextStyle get subtitle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get subtitleLight => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.5,
  );

  static TextStyle get textFieldText => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: AppColors.emailText,
    height: 1.5,
  );
}

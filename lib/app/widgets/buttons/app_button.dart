import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';

enum ButtonVariant { primary, secondary }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final ButtonVariant variant;
  final double? width;
  final double? height;
  final bool isLoading;
  final Widget? suffixIcon;
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.width,
    this.height,
    this.isLoading = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = variant == ButtonVariant.primary
        ? AppColors.primaryBlue
        : AppColors.buttonSecondary;

    final textColor = variant == ButtonVariant.primary
        ? AppColors.buttonTextPrimary
        : AppColors.buttonTextSecondary;

    final borderColor = variant == ButtonVariant.secondary
        ? AppColors.buttonTextPrimary
        : AppColors.buttonTextPrimary;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppDimensions.buttonHeightM,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (icon != null) ...[icon!],
                  Text(
                    text,
                    style: variant == ButtonVariant.primary
                        ? AppTextStyles.buttonText
                        : AppTextStyles.buttonTextSecondary,
                  ),
                  if (suffixIcon != null) ...[suffixIcon!],
                ],
              ),
      ),
    );
  }
}

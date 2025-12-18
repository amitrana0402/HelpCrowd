import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool showBorder;
  final Color? textColor;

  const CustomTextField({
    super.key,
    this.hint,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.showBorder = true,
    this.textColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  late bool _isPasswordField;

  @override
  void initState() {
    super.initState();
    _isPasswordField = widget.obscureText;
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _isPasswordField ? _obscureText : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textAlign: TextAlign.center,
      style: AppTextStyles.textFieldText.copyWith(
        color: widget.textColor ?? AppColors.inputText,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: AppTextStyles.textFieldText.copyWith(
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingM,
        ),
        border: widget.showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              )
            : InputBorder.none,
        enabledBorder: widget.showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              )
            : InputBorder.none,
        focusedBorder: widget.showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(
                  color: AppColors.inputBorderFocused,
                  width: 2,
                ),
              )
            : InputBorder.none,
        errorBorder: widget.showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(color: AppColors.error),
              )
            : InputBorder.none,
        focusedErrorBorder: widget.showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(color: AppColors.error, width: 2),
              )
            : InputBorder.none,
        suffixIcon: _isPasswordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}

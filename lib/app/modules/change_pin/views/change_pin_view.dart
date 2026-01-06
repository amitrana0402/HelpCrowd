import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../controllers/change_pin_controller.dart';

class ChangePinView extends GetView<ChangePinController> {
  const ChangePinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildContent(),
            ),
            _buildKeypad(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: controller.onBackTap,
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
      ),
      title: Text(
        'CHANGE PIN',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingXL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppDimensions.paddingXL),
          Obx(() => Text(
                controller.instructionText,
                style: AppTextStyles.bodyLarge,
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: AppDimensions.paddingXL),
          _buildPinInput(),
          const SizedBox(height: AppDimensions.paddingL),
          Text(
            'You can add or remove the PIN later from the Settings menu.',
            style: AppTextStyles.caption.copyWith(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingXL),
          Obx(() => _buildConfirmButton()),
        ],
      ),
    );
  }

  Widget _buildPinInput() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final digit = controller.currentPinDigits[index];
          final isActive = index == controller.currentDigitIndex.value;
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
            child: _buildPinCircle(digit, isActive),
          );
        }),
      ),
    );
  }

  Widget _buildPinCircle(String? digit, bool isActive) {
    if (digit != null && isActive) {
      // Digit entered and currently active (showing cursor)
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              digit,
              style: AppTextStyles.h2Light.copyWith(
                fontSize: 24,
              ),
            ),
            Positioned(
              bottom: 12,
              child: _BlinkingCursor(
                child: Container(
                  width: 2,
                  height: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (digit != null) {
      // Digit entered but not active
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            digit,
            style: AppTextStyles.h2Light.copyWith(
              fontSize: 24,
            ),
          ),
        ),
      );
    } else if (isActive) {
      // Empty and active (showing cursor)
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryBlue,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _BlinkingCursor(
            child: Container(
              width: 2,
              height: 30,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
      );
    } else {
      // Empty and not active
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.lightGrey,
            width: 2,
          ),
          shape: BoxShape.circle,
        ),
      );
    }
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.canConfirm ? controller.onConfirmTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.canConfirm
              ? AppColors.primaryBlue
              : AppColors.lightGrey,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          elevation: 0,
        ),
        child: Text(
          'Confirm',
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Container(
      color: AppColors.lightGrey.withOpacity(0.3),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        children: [
          _buildKeypadRow(['1', '2', '3']),
          const SizedBox(height: AppDimensions.paddingM),
          _buildKeypadRow(['4', '5', '6']),
          const SizedBox(height: AppDimensions.paddingM),
          _buildKeypadRow(['7', '8', '9']),
          const SizedBox(height: AppDimensions.paddingM),
          _buildKeypadBottomRow(),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        return _buildKeypadButton(
          number,
          onTap: () => controller.onNumberTap(number),
        );
      }).toList(),
    );
  }

  Widget _buildKeypadBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 100), // Empty space
        _buildKeypadButton(
          '0',
          onTap: () => controller.onNumberTap('0'),
        ),
        _buildKeypadButton(
          '',
          isDelete: true,
          onTap: controller.onDeleteTap,
        ),
      ],
    );
  }

  Widget _buildKeypadButton(
    String number, {
    required VoidCallback onTap,
    bool isDelete = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isDelete
              ? const Icon(
                  Icons.backspace_outlined,
                  color: AppColors.textPrimary,
                  size: AppDimensions.iconM,
                )
              : Text(
                  number,
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 28,
                  ),
                ),
        ),
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  final Widget child;

  const _BlinkingCursor({required this.child});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 0.5 + (_controller.value * 0.5), // Blink between 0.5 and 1.0
          child: widget.child,
        );
      },
    );
  }
}


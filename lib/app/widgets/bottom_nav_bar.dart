import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool showNotificationDot;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showNotificationDot = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            unselectedIcon: AppImages.navHome,
            selectedIcon: AppImages.navHomeSelected,
            label: 'Home',
          ),
          _buildNavItem(
            index: 1,
            unselectedIcon: AppImages.navTransaction,
            selectedIcon: AppImages.navTransactionSelected,
            label: 'Transactions',
          ),
          _buildNavItem(index: 2, isIcon: true, label: 'Profile'),
          _buildNavItem(
            index: 3,
            unselectedIcon: AppImages.navNotification,
            selectedIcon: AppImages.navNotificationSelected,
            label: 'Notifications',
            showDot: showNotificationDot,
          ),
          _buildNavItem(
            index: 4,
            unselectedIcon: AppImages.navSetting,
            selectedIcon: AppImages.navSettingSelected,
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    String? unselectedIcon,
    String? selectedIcon,
    bool isIcon = false,
    String? label,
    bool showDot = false,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                isIcon
                    ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : AppColors.lightGrey,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: isSelected ? AppColors.white : AppColors.grey,
                          size: 24,
                        ),
                      )
                    : unselectedIcon != null
                    ? Image.asset(
                        isSelected && selectedIcon != null
                            ? selectedIcon
                            : unselectedIcon,
                        width: 24,
                        height: 24,
                      )
                    : const SizedBox(width: 24, height: 24),
                if (showDot)
                  Positioned(
                    bottom: -12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

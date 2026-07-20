import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class TrendyBottomNav extends StatelessWidget {
  const TrendyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAdd,
    this.homeLabel = 'Home',
    this.shipmentsLabel = 'Shipments',
    this.profileLabel = 'Profile',
    this.settingsLabel = 'Settings',
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;
  final String homeLabel;
  final String shipmentsLabel;
  final String profileLabel;
  final String settingsLabel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                _buildNavItem(0, Icons.home, homeLabel),
                _buildNavItem(1, Icons.local_shipping, shipmentsLabel),
                const Spacer(),
                _buildNavItem(2, Icons.person, profileLabel),
                _buildNavItem(3, Icons.settings, settingsLabel),
              ],
            ),
            Positioned(
              top: 12,
              left: MediaQuery.of(context).size.width / 2 - 28,
              child: FloatingActionButton(
                onPressed: onAdd,
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 4,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color:
                      isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';

class StreakFireBadge extends StatelessWidget {
  const StreakFireBadge({super.key, required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = streak > 0;
    final accentColor = streak > 7 ? AppColors.streakOrange : AppColors.grey500;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: isActive ? AppColors.streakOrange.withValues(alpha: 0.16) : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department_rounded, color: isActive ? accentColor : AppColors.grey500, size: 18),
          const SizedBox(width: AppSpacing.xs),
          Text('$streak', style: AppTypography.labelLarge.copyWith(color: isActive ? theme.colorScheme.onSurface : AppColors.grey500)),
        ],
      ),
    );
  }
}

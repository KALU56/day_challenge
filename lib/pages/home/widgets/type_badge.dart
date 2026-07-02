import 'package:flutter/material.dart';
import 'package:day_challenge/app/app_color.dart';

enum ChallengeBadgeType { private, friend }

class TypeBadge extends StatelessWidget {
  const TypeBadge({super.key, required this.type, required this.label});

  final ChallengeBadgeType type;
  final String label;

  @override
  Widget build(BuildContext context) {
    final bool isFriend = type == ChallengeBadgeType.friend;
    final Color background = isFriend
        ? AppColors.darkFreezeBg
        : Theme.of(context).colorScheme.primary.withValues(alpha: 0.12);
    final Color textColor = isFriend
        ? AppColors.darkFreeze
        : Theme.of(context).colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

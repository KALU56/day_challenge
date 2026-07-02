import 'package:flutter/material.dart';

import 'app_progress_bar.dart';
import 'streak_chip.dart';
import 'type_badge.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.title,
    required this.badgeLabel,
    required this.badgeType,
    required this.progress,
    this.streakDays,
  });

  final String title;
  final String badgeLabel;
  final ChallengeBadgeType badgeType;
  final double progress;
  final int? streakDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 320;

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (streakDays != null) StreakChip(value: streakDays!),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (streakDays != null) StreakChip(value: streakDays!),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            children: [
              TypeBadge(type: badgeType, label: badgeLabel),
              Text(
                '${(progress * 100).round()}% done',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppProgressBar(value: progress),
        ],
      ),
    );
  }
}

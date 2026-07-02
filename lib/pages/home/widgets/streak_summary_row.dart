import 'package:flutter/material.dart';

import '../../../app/app_color.dart';

class StreakSummaryRow extends StatelessWidget {
  const StreakSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 420;
        final spacing = isCompact ? 10.0 : 12.0;

        final cards = [
          _SummaryCard(
            label: 'Current streak',
            value: '6d',
            subtext: 'Flame pace',
            accent: _SummaryAccent.streak,
            isCompact: isCompact,
          ),
          _SummaryCard(
            label: 'Today complete',
            value: '67%',
            subtext: 'On track',
            accent: _SummaryAccent.progress,
            isCompact: isCompact,
          ),
          _SummaryCard(
            label: 'Total progress',
            value: '82%',
            subtext: 'Goal rhythm',
            accent: _SummaryAccent.trophy,
            isCompact: isCompact,
          ),
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              for (var index = 0; index < cards.length; index++) ...[
                if (index > 0) SizedBox(width: spacing),
                SizedBox(width: isCompact ? 180 : 200, child: cards[index]),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.subtext,
    required this.accent,
    this.isCompact = false,
  });

  final String label;
  final String value;
  final String subtext;
  final _SummaryAccent accent;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = Theme.of(context).colorScheme.surface
        .withValues(alpha: 0.15);

    final verticalPadding = isCompact ? 12.0 : 14.0;
    final horizontalPadding = isCompact ? 12.0 : 14.0;
    final labelValueGap = isCompact ? 8.0 : 10.0;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryAccentIcon(accent: accent, isCompact: isCompact),
          SizedBox(width: isCompact ? 10.0 : 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(
                      alpha: 0.72,
                    ),
                    fontSize: isCompact ? 11 : 12,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: labelValueGap),
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: isCompact ? 18 : 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtext,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                    fontSize: isCompact ? 11 : 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _SummaryAccent { streak, progress, trophy }

class _SummaryAccentIcon extends StatelessWidget {
  const _SummaryAccentIcon({required this.accent, this.isCompact = false});

  final _SummaryAccent accent;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final IconData icon;

    switch (accent) {
      case _SummaryAccent.streak:
        background = AppColors.primary.withValues(alpha: 0.16);
        icon = Icons.local_fire_department_rounded;
        break;
      case _SummaryAccent.progress:
        background = AppColors.coinGold.withValues(alpha: 0.18);
        icon = Icons.bar_chart_rounded;
        break;
      case _SummaryAccent.trophy:
        background = AppColors.darkSuccess.withValues(alpha: 0.18);
        icon = Icons.emoji_events_rounded;
        break;
    }

    final padding = isCompact ? 8.0 : 10.0;
    final iconSize = isCompact ? 14.0 : 18.0;

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(padding),
      child: Icon(icon, size: iconSize, color: Colors.white),
    );
  }
}

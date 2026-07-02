import 'package:flutter/material.dart';

import '../../../app/app_color.dart';

class StreakSummaryRow extends StatelessWidget {
  const StreakSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;
        final twoColumn = constraints.maxWidth < 900;

        if (compact) {
          return Column(
            children: const [
              _SummaryCard(
                label: 'Current streak',
                value: '6d',
                subtext: 'Flame pace',
                accent: _SummaryAccent.streak,
              ),
              SizedBox(height: 12),
              _SummaryCard(
                label: 'Today complete',
                value: '67%',
                subtext: 'On track',
                accent: _SummaryAccent.progress,
              ),
              SizedBox(height: 12),
              _SummaryCard(
                label: 'Total progress',
                value: '82%',
                subtext: 'Goal rhythm',
                accent: _SummaryAccent.trophy,
              ),
            ],
          );
        }

        if (twoColumn) {
          final cardWidth = (constraints.maxWidth - 12) / 2;
          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: cardWidth,
                child: const _SummaryCard(
                  label: 'Current streak',
                  value: '6d',
                  subtext: 'Flame pace',
                  accent: _SummaryAccent.streak,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const _SummaryCard(
                  label: 'Today complete',
                  value: '67%',
                  subtext: 'On track',
                  accent: _SummaryAccent.progress,
                ),
              ),
              SizedBox(
                width: cardWidth,
                child: const _SummaryCard(
                  label: 'Total progress',
                  value: '82%',
                  subtext: 'Goal rhythm',
                  accent: _SummaryAccent.trophy,
                ),
              ),
            ],
          );
        }

        return Row(
          children: const [
            Expanded(
              child: _SummaryCard(
                label: 'Current streak',
                value: '6d',
                subtext: 'Flame pace',
                accent: _SummaryAccent.streak,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'Today complete',
                value: '67%',
                subtext: 'On track',
                accent: _SummaryAccent.progress,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'Total progress',
                value: '82%',
                subtext: 'Goal rhythm',
                accent: _SummaryAccent.trophy,
              ),
            ),
          ],
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
  });

  final String label;
  final String value;
  final String subtext;
  final _SummaryAccent accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = Theme.of(context).colorScheme.surface
        .withValues(alpha: 0.15);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              _SummaryAccentIcon(accent: accent),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 72),
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withValues(
                      alpha: 0.72,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtext,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }
}

enum _SummaryAccent { streak, progress, trophy }

class _SummaryAccentIcon extends StatelessWidget {
  const _SummaryAccentIcon({required this.accent});

  final _SummaryAccent accent;

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

    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}

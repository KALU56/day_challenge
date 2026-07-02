import 'package:day_challenge/app/app_color.dart';
import 'package:flutter/material.dart';
import '../../../app/app_color.dart';

enum DayState {
  normal,
  streak,
  freeze,
}

class ChallengeCalendarDay {
  const ChallengeCalendarDay({
    required this.label,
    required this.number,
    this.state = DayState.normal,
  });

  final String label;
  final int number;
  final DayState state;
}

class ChallengeCalendarTimeline extends StatefulWidget {
  const ChallengeCalendarTimeline({
    super.key,
    this.days,
    this.onDaySelected,
  });

  final List<ChallengeCalendarDay>? days;
  final ValueChanged<ChallengeCalendarDay>? onDaySelected;

  @override
  State<ChallengeCalendarTimeline> createState() =>
      _ChallengeCalendarTimelineState();
}

class _ChallengeCalendarTimelineState
    extends State<ChallengeCalendarTimeline> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final days = widget.days ?? _defaultDays;

    return SizedBox(
      // height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onDaySelected?.call(day);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isSelected ? 86 : 72,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? color.surface
                    : color.surface.withValues(alpha: isDark ? 0.6 : 0.9),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.25)
                      : isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          blurRadius: 12,
                          color: Colors.black.withValues(alpha: 0.12),
                          offset: const Offset(0, 6),
                        )
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // DAY LABEL
                  Text(
                    day.label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ICON + NUMBER
                  Column(
                    children: [
                      _icon(day, isDark),
                      const SizedBox(height: 2),
                      Text(
                        '${day.number}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // SELECTED INDICATOR
                  if (isSelected)
                    Container(
                      width: 18,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _icon(ChallengeCalendarDay day, bool isDark) {
    switch (day.state) {
      case DayState.streak:
        return const Icon(
          Icons.local_fire_department_rounded,
          size: 16,
          color: AppColors.coinGold,
        );

      case DayState.freeze:
        return Icon(
          Icons.ac_unit_rounded,
          size: 16,
          color: isDark
              ? AppColors.darkFreeze
              : AppColors.lightFreeze,
        );

      case DayState.normal:
        return const SizedBox(height: 16);
    }
  }
}

const _defaultDays = [
  ChallengeCalendarDay(label: 'Mon', number: 8),
  ChallengeCalendarDay(label: 'Tue', number: 9, state: DayState.streak),
  ChallengeCalendarDay(label: 'Wed', number: 10),
  ChallengeCalendarDay(label: 'Thu', number: 11, state: DayState.freeze),
  ChallengeCalendarDay(label: 'Fri', number: 12),
  ChallengeCalendarDay(label: 'Sat', number: 13),
  ChallengeCalendarDay(label: 'Sun', number: 14),
];
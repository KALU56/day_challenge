import 'package:flutter/material.dart';

import '../../../app/app_color.dart';

enum ChallengeCalendarDayState {
  current,
  completed,
  streak,
  freeze,
  future,
  missed,
}

class ChallengeCalendarDay {
  const ChallengeCalendarDay({
    required this.label,
    required this.number,
    required this.state,
  });

  final String label;
  final int number;
  final ChallengeCalendarDayState state;
}

class ChallengeCalendarTimeline extends StatefulWidget {
  const ChallengeCalendarTimeline({super.key, this.days, this.onDaySelected});

  final List<ChallengeCalendarDay>? days;
  final ValueChanged<ChallengeCalendarDay>? onDaySelected;

  @override
  State<ChallengeCalendarTimeline> createState() =>
      _ChallengeCalendarTimelineState();
}

class _ChallengeCalendarTimelineState extends State<ChallengeCalendarTimeline> {
  late final ScrollController _scrollController;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _selectedIndex = _initialSelectedIndex();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) {
        return;
      }

      final itemWidth = 84.0;
      _scrollController.animateTo(
        _selectedIndex * itemWidth,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _initialSelectedIndex() {
    final days = widget.days ?? _defaultDays;
    final currentIndex = days.indexWhere(
      (day) => day.state == ChallengeCalendarDayState.current,
    );
    return currentIndex >= 0 ? currentIndex : 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = widget.days ?? _defaultDays;

    if (_selectedIndex >= days.length) {
      _selectedIndex = days.length - 1;
    }

    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Challenge timeline',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(top: 4, bottom: 6),
          decoration: BoxDecoration(
            color: theme.cardColor.withValues(alpha: isDark ? 0.55 : 0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.colorScheme.surface.withValues(alpha: 0.16),
            ),
          ),
          child: SizedBox(
            height: 132,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Row(
                children: [
                  for (var index = 0; index < days.length; index++) ...[
                    if (index > 0) const SizedBox(width: 10),
                    _buildDayItem(theme, days[index], index, isDark),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayItem(
    ThemeData theme,
    ChallengeCalendarDay day,
    int index,
    bool isDark,
  ) {
    final isSelected = index == _selectedIndex;
    final isCurrent = day.state == ChallengeCalendarDayState.current;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        widget.onDaySelected?.call(day);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        scale: isSelected ? 1.03 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isSelected ? 84 : 74,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: _backgroundColor(theme, day, isSelected, isDark),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _borderColor(theme, day, isDark),
              width: isSelected ? 1.2 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.08),
                blurRadius: isSelected ? 18 : 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _labelColor(theme, day, isDark),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isCurrent ? 34 : 30,
                height: isCurrent ? 34 : 30,
                decoration: BoxDecoration(
                  color: _indicatorColor(theme, day, isDark),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _indicatorBorderColor(theme, day, isDark),
                    width: isCurrent ? 1.6 : 1.0,
                  ),
                ),
                child: Center(child: _buildStatusContent(theme, day)),
              ),
              const SizedBox(height: 8),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                opacity: isCurrent ? 1 : 0.0,
                child: Container(
                  width: 18,
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: _indicatorColor(theme, day, isDark),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusContent(ThemeData theme, ChallengeCalendarDay day) {
    final color = _iconColor(theme, day);

    switch (day.state) {
      case ChallengeCalendarDayState.current:
        return Text(
          day.number.toString(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        );
      case ChallengeCalendarDayState.completed:
        return Icon(Icons.check_rounded, size: 16, color: color);
      case ChallengeCalendarDayState.streak:
        return Icon(
          Icons.local_fire_department_rounded,
          size: 16,
          color: color,
        );
      case ChallengeCalendarDayState.freeze:
        return Icon(Icons.ac_unit_rounded, size: 16, color: color);
      case ChallengeCalendarDayState.missed:
        return Icon(Icons.close_rounded, size: 16, color: color);
      case ChallengeCalendarDayState.future:
        return Text(
          day.number.toString(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }

  Color _backgroundColor(
    ThemeData theme,
    ChallengeCalendarDay day,
    bool isSelected,
    bool isDark,
  ) {
    final selectedSurface = isDark
        ? AppColors.darkSurface2
        : AppColors.lightSurface2;

    switch (day.state) {
      case ChallengeCalendarDayState.current:
        return isSelected ? theme.colorScheme.surface : theme.cardColor;
      case ChallengeCalendarDayState.completed:
        return isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
      case ChallengeCalendarDayState.streak:
        return isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
      case ChallengeCalendarDayState.freeze:
        return isDark ? AppColors.darkFreezeBg : AppColors.lightFreezeBg;
      case ChallengeCalendarDayState.future:
        return isSelected
            ? selectedSurface
            : theme.cardColor.withValues(alpha: 0.8);
      case ChallengeCalendarDayState.missed:
        return theme.cardColor.withValues(alpha: 0.64);
    }
  }

  Color _borderColor(ThemeData theme, ChallengeCalendarDay day, bool isDark) {
    switch (day.state) {
      case ChallengeCalendarDayState.current:
        return isDark ? AppColors.darkBorder : AppColors.lightBorder;
      case ChallengeCalendarDayState.streak:
        return isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
      case ChallengeCalendarDayState.freeze:
        return isDark ? AppColors.darkFreeze : AppColors.lightFreeze;
      case ChallengeCalendarDayState.completed:
        return isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
      case ChallengeCalendarDayState.future:
        return isDark ? AppColors.darkBorder : AppColors.lightBorder;
      case ChallengeCalendarDayState.missed:
        return isDark ? AppColors.darkBorder : AppColors.lightBorder;
    }
  }

  Color _labelColor(ThemeData theme, ChallengeCalendarDay day, bool isDark) {
    switch (day.state) {
      case ChallengeCalendarDayState.current:
        return theme.colorScheme.onSurface;
      case ChallengeCalendarDayState.completed:
      case ChallengeCalendarDayState.streak:
        return Colors.white;
      case ChallengeCalendarDayState.freeze:
        return isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
      case ChallengeCalendarDayState.future:
        return theme.colorScheme.onSurface.withValues(alpha: 0.7);
      case ChallengeCalendarDayState.missed:
        return theme.colorScheme.onSurface.withValues(alpha: 0.55);
    }
  }

  Color _indicatorColor(
    ThemeData theme,
    ChallengeCalendarDay day,
    bool isDark,
  ) {
    switch (day.state) {
      case ChallengeCalendarDayState.current:
        return theme.colorScheme.primary;
      case ChallengeCalendarDayState.completed:
        return Colors.white;
      case ChallengeCalendarDayState.streak:
        return AppColors.coinGold;
      case ChallengeCalendarDayState.freeze:
        return isDark ? AppColors.darkFreeze : AppColors.lightFreeze;
      case ChallengeCalendarDayState.future:
        return theme.colorScheme.onSurface.withValues(alpha: 0.3);
      case ChallengeCalendarDayState.missed:
        return theme.colorScheme.onSurface.withValues(alpha: 0.35);
    }
  }

  Color _indicatorBorderColor(
    ThemeData theme,
    ChallengeCalendarDay day,
    bool isDark,
  ) {
    switch (day.state) {
      case ChallengeCalendarDayState.current:
        return theme.colorScheme.primary.withValues(alpha: 0.2);
      case ChallengeCalendarDayState.completed:
        return Colors.white;
      case ChallengeCalendarDayState.streak:
        return AppColors.coinGold;
      case ChallengeCalendarDayState.freeze:
        return isDark ? AppColors.darkFreeze : AppColors.lightFreeze;
      case ChallengeCalendarDayState.future:
        return theme.colorScheme.onSurface.withValues(alpha: 0.15);
      case ChallengeCalendarDayState.missed:
        return theme.colorScheme.onSurface.withValues(alpha: 0.18);
    }
  }

  Color _iconColor(ThemeData theme, ChallengeCalendarDay day) {
    switch (day.state) {
      case ChallengeCalendarDayState.completed:
      case ChallengeCalendarDayState.streak:
        return Colors.white;
      case ChallengeCalendarDayState.freeze:
        return theme.brightness == Brightness.dark
            ? AppColors.darkFreeze
            : AppColors.lightFreeze;
      case ChallengeCalendarDayState.current:
        return theme.colorScheme.onPrimary;
      case ChallengeCalendarDayState.future:
        return theme.colorScheme.onSurface.withValues(alpha: 0.65);
      case ChallengeCalendarDayState.missed:
        return theme.colorScheme.onSurface.withValues(alpha: 0.5);
    }
  }
}

const List<ChallengeCalendarDay> _defaultDays = [
  ChallengeCalendarDay(
    label: 'Mon',
    number: 8,
    state: ChallengeCalendarDayState.completed,
  ),
  ChallengeCalendarDay(
    label: 'Tue',
    number: 9,
    state: ChallengeCalendarDayState.streak,
  ),
  ChallengeCalendarDay(
    label: 'Wed',
    number: 10,
    state: ChallengeCalendarDayState.current,
  ),
  ChallengeCalendarDay(
    label: 'Thu',
    number: 11,
    state: ChallengeCalendarDayState.freeze,
  ),
  ChallengeCalendarDay(
    label: 'Fri',
    number: 12,
    state: ChallengeCalendarDayState.future,
  ),
  ChallengeCalendarDay(
    label: 'Sat',
    number: 13,
    state: ChallengeCalendarDayState.future,
  ),
  ChallengeCalendarDay(
    label: 'Sun',
    number: 14,
    state: ChallengeCalendarDayState.missed,
  ),
];

import 'package:flutter/material.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key, required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      tween: Tween(begin: 0, end: value),
      builder: (context, animatedValue, child) {
        final theme = Theme.of(context);

        return Container(
          height: 9,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: animatedValue.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../app/app_color.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavTheme = theme.bottomNavigationBarTheme;

    // Use existing colors from the theme and AppColors.
    final barBackgroundColor = bottomNavTheme.backgroundColor ?? theme.colorScheme.surface;
    final bubbleColor = theme.colorScheme.primary; 
    
    // We set backgroundColor to Colors.transparent here.
    const cutoutBackgroundColor = Colors.transparent;

    // Determine icon colors dynamically.
    Color getIconColor(int index) {
      if (currentIndex == index) {
        return theme.colorScheme.onPrimary;
      }
      return bottomNavTheme.unselectedItemColor ??
          (theme.brightness == Brightness.dark
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary);
    }

    return CurvedNavigationBar(
      index: currentIndex,
      height: 65.0, // Existing design token sizing approximation
      color: barBackgroundColor,
      buttonBackgroundColor: bubbleColor,
      backgroundColor: cutoutBackgroundColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: onTap,
      items: <Widget>[
        Icon(Icons.home_rounded, size: 28, color: getIconColor(0)),
        Icon(Icons.add, size: 28, color: getIconColor(1)),
        Icon(Icons.local_fire_department_rounded, size: 28, color: getIconColor(2)),
        Icon(Icons.settings_outlined, size: 28, color: getIconColor(3)),
        Icon(Icons.person_outline_rounded, size: 28, color: getIconColor(4)),
      ],
    );
  }
}

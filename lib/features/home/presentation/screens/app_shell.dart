import 'package:flutter/material.dart';

import 'home_tab_screen.dart';
import 'mine_tab_screen.dart';
import '../../../social/presentation/screens/social_tab_screen.dart';
import 'me_tab_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    const HomeTabScreen(),
    const MineTabScreen(),
    const SocialTabScreen(),
    const MeTabScreen(),
  ];

  static const List<String> _labels = ['Home', 'Mine', 'Social', 'Me'];
  static const List<IconData> _icons = [
    Icons.home_filled,
    Icons.checklist_rtl,
    Icons.people,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: List.generate(
          _labels.length,
          (index) => NavigationDestination(
            icon: Icon(_icons[index]),
            label: _labels[index],
          ),
        ),
      ),
    );
  }
}

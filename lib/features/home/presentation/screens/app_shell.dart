import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home_tab_screen.dart';
import 'me_tab_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTabScreen(),
    const _SearchScreen(),
    const _FavoritesScreen(),
    const _SettingsScreen(),
    const MeTabScreen(),
  ];

  final List<IconData> _icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.settings,
    Icons.person,
  ];

  final List<String> _labels = [
    'Home',
    'Search',
    'Favorites',
    'Settings',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 70,
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Colors.blue,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: List.generate(_icons.length, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _icons[index],
                size: 24,
                color: _selectedIndex == index ? Colors.white : Colors.black87,
              ),
              const SizedBox(height: 4),
              Text(
                _labels[index],
                style: TextStyle(
                  fontSize: 10,
                  color: _selectedIndex == index ? Colors.blue : Colors.black54,
                  fontWeight: _selectedIndex == index
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ],
          );
        }),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class _SearchScreen extends StatelessWidget {
  const _SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Screen'));
  }
}

class _FavoritesScreen extends StatelessWidget {
  const _FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Favorites Screen'));
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Screen'));
  }
}

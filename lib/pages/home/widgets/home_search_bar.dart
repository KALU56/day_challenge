import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search habits, friends...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: const Icon(Icons.mic_none_rounded),
        ),
      ),
    );
  }
}

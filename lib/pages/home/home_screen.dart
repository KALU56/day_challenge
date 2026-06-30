import 'package:flutter/material.dart';

import '../../widgets/navigation/main_bottom_nav_bar.dart';
import 'widgets/categories_section.dart';
import 'widgets/continue_section.dart';
import 'widgets/featured_banner.dart';
import 'widgets/greeting_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/popular_items_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: HomeAppBar()),
            const SliverToBoxAdapter(child: GreetingSection()),
            const SliverToBoxAdapter(child: HomeSearchBar()),
            const SliverToBoxAdapter(child: FeaturedBanner()),
            const SliverToBoxAdapter(child: CategoriesSection()),
            const SliverToBoxAdapter(child: PopularItemsSection()),
            const SliverToBoxAdapter(child: ContinueSection()),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)), // Space for bottom nav bar
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

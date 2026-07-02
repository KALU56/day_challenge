import 'package:flutter/material.dart';

import '../../widgets/navigation/main_bottom_nav_bar.dart';
import 'widgets/all_done_banner.dart';
import 'widgets/challenge_calendar_timeline.dart';
import 'widgets/challenge_card.dart';
import 'widgets/freeze_received_banner.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/motivation_card.dart';
import 'widgets/promise_pending_banner.dart';
import 'widgets/streak_summary_row.dart';
import 'widgets/type_badge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _horizontalPadding = 20;

  int _selectedIndex = 0;

  final List<_ChallengeItem> _challenges = const [
    _ChallengeItem(
      title: 'Read 10 pages',
      badgeLabel: 'Private',
      badgeType: ChallengeBadgeType.private,
      progress: 0.72,
      streakDays: 6,
      showStreakChip: true,
    ),
    _ChallengeItem(
      title: 'Gym with Sara',
      badgeLabel: 'Friend',
      badgeType: ChallengeBadgeType.friend,
      progress: 0.46,
      streakDays: 4,
      showStreakChip: false,
    ),
    _ChallengeItem(
      title: 'Morning journaling',
      badgeLabel: 'Private',
      badgeType: ChallengeBadgeType.private,
      progress: 0.88,
      streakDays: 12,
      showStreakChip: true,
    ),
  ];

  final bool _showPromiseBanner = true;
  final bool _showFreezeBanner = false;
  final bool _showAllDoneBanner = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding,
              vertical: 14,
            ),
            child: HomeAppBar(onGiftTap: () {}, onNotificationTap: () {}),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final contentMaxWidth = constraints.maxWidth > 920
              ? 920.0
              : constraints.maxWidth;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentMaxWidth),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: _horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const ChallengeCalendarTimeline(),
                    const SizedBox(height: 22),
                    const MotivationCard(),
                    const SizedBox(height: 22),
                    const StreakSummaryRow(),
                    const SizedBox(height: 22),
                    Column(
                      children: _challenges
                          .map(
                            (challenge) => Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: ChallengeCard(
                                title: challenge.title,
                                badgeLabel: challenge.badgeLabel,
                                badgeType: challenge.badgeType,
                                progress: challenge.progress,
                                streakDays: challenge.showStreakChip
                                    ? challenge.streakDays
                                    : null,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    if (_showPromiseBanner) ...[
                      const PromisePendingBanner(),
                      const SizedBox(height: 16),
                    ],
                    if (_showFreezeBanner) ...[
                      const FreezeReceivedBanner(),
                      const SizedBox(height: 16),
                    ],
                    if (_showAllDoneBanner) const AllDoneBanner(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _ChallengeItem {
  const _ChallengeItem({
    required this.title,
    required this.badgeLabel,
    required this.badgeType,
    required this.progress,
    required this.streakDays,
    required this.showStreakChip,
  });

  final String title;
  final String badgeLabel;
  final ChallengeBadgeType badgeType;
  final double progress;
  final int streakDays;
  final bool showStreakChip;
}

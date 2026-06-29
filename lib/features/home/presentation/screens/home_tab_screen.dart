import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/challenge/view_models/challenge_list_notifier.dart';
import '../../../../features/profile/view_models/profile_notifier.dart';
import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/radius.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/badges/streak_fire_badge.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/coin_badge.dart';

class HomeTabScreen extends ConsumerWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    final challengeState = ref.watch(challengeListProvider);

    return profileState.when(
      data: (profile) {
        final username = profile?.username ?? 'Friend';
        final coins = profile?.coins ?? 0;

        return challengeState.when(
          data: (items) {
            final activeChallenges = items
                .where((item) => !item.isCompleted)
                .toList();
            final bestStreak = items.fold<int>(
              0,
              (previousValue, element) => max(previousValue, element.streak),
            );
            final completedCount = items
                .where((item) => item.isCompleted)
                .length;

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning, $username',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.grey500,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Ready for today?',
                            style: AppTypography.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    CoinBadge(coins: coins),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$bestStreak day streak',
                        style: AppTypography.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      StreakFireBadge(streak: bestStreak),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        '$completedCount challenge${completedCount == 1 ? '' : 's'} completed. Keep the momentum going!',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (activeChallenges.isEmpty)
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No active challenges yet',
                          style: AppTypography.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Create your first challenge to start building consistency.',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...activeChallenges.take(2).map((challenge) {
                    final progress =
                        ((challenge.completedDates.length /
                                    max(1, challenge.durationDays)) *
                                100)
                            .round();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: GlassCard(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          onTap: () =>
                              GoRouter.of(context)
                                  .go('/challenges/${challenge.id}'),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  challenge.title,
                                  style: AppTypography.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  challenge.description,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.grey500,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Row(
                                  children: [
                                    StreakFireBadge(streak: challenge.streak),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value:
                                            challenge.completedDates.length /
                                            max(1, challenge.durationDays),
                                        color: AppColors.primary,
                                        backgroundColor: AppColors.primary
                                            .withValues(alpha: 0.14),
                                        minHeight: 6,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Text(
                                      '$progress%',
                                      style: AppTypography.labelSmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: 'Create new challenge',
                  onPressed: () =>
                      GoRouter.of(context).go('/challenges/create'),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              Center(child: Text('Unable to load challenges: $error')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text('Unable to load profile: $error')),
    );
  }
}

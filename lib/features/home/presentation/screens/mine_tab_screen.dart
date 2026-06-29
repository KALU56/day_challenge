import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/challenge/view_models/challenge_list_notifier.dart';
import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/radius.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/coin_badge.dart';
import '../../../../design_system/widgets/badges/streak_fire_badge.dart';

class MineTabScreen extends ConsumerWidget {
  const MineTabScreen({super.key});

  Widget _challengeCard({
    required String title,
    required String subtitle,
    required int progress,
    required int streak,
    required Color badgeColor,
    VoidCallback? onTap,
  }) {
    return GlassCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(title, style: AppTypography.titleLarge)),
                  StreakFireBadge(streak: streak),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                subtitle,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      color: badgeColor,
                      backgroundColor: badgeColor.withValues(alpha: 0.15),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(
                      '$progress%',
                      style: AppTypography.labelSmall.copyWith(
                        color: badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeListProvider);

    return state.when(
      data: (items) {
        final activeChallenges = items
            .where((challenge) => !challenge.isCompleted)
            .toList();
        final completedChallenges = items
            .where((challenge) => challenge.isCompleted)
            .toList();

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text('My challenges', style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            if (activeChallenges.isEmpty)
              GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'No active challenges yet',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ),
              )
            else
              ...activeChallenges.map((challenge) {
                final progress =
                    ((challenge.completedDates.length /
                                max(1, challenge.durationDays)) *
                            100)
                        .round();
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _challengeCard(
                    title: challenge.title,
                    subtitle:
                        'Day ${challenge.completedDates.length} of ${challenge.durationDays} · ${challenge.streak} streak',
                    progress: progress,
                    streak: challenge.streak,
                    badgeColor: challenge.isCompleted
                        ? AppColors.success
                        : AppColors.primary,
                    onTap: () =>
                        GoRouter.of(context).go('/challenges/${challenge.id}'),
                  ),
                );
              }),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed', style: AppTypography.titleLarge),
                CoinBadge(
                  coins: items.fold<int>(
                    0,
                    (sum, challenge) => sum + (challenge.isCompleted ? 1 : 0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (completedChallenges.isEmpty)
              GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'No completed challenges yet',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ),
              )
            else
              ...completedChallenges
                  .take(2)
                  .map(
                    (challenge) => GlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 28,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    challenge.title,
                                    style: AppTypography.titleMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    '${challenge.durationDays} days · +${challenge.durationDays * 10} coins',
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.grey500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              label: 'Create a new challenge',
              onPressed: () {
                GoRouter.of(context).go('/challenges/create');
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text('Unable to load challenges: $error')),
    );
  }
}

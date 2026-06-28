import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/radius.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/coin_badge.dart';
import '../../../../design_system/widgets/badges/streak_fire_badge.dart';

class MineTabScreen extends StatelessWidget {
  const MineTabScreen({super.key});

  Widget _challengeCard({
    required String title,
    required String subtitle,
    required int progress,
    required int streak,
    required String badgeLabel,
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
                  const StreakFireBadge(streak: 0),
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
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('My challenges', style: AppTypography.headlineMedium),
        const SizedBox(height: AppSpacing.md),
        _challengeCard(
          title: 'Drink water',
          subtitle: 'Day 12 of 21 · 12 streak',
          progress: 57,
          streak: 12,
          badgeLabel: 'Private',
          badgeColor: AppColors.primary,
          onTap: () {
            GoRouter.of(context).go('/challenges/active-1');
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _challengeCard(
          title: 'Read 10 pages',
          subtitle: 'Day 5 of 7 · 5 streak',
          progress: 71,
          streak: 5,
          badgeLabel: 'Friend',
          badgeColor: AppColors.promisePurple,
          onTap: () {
            GoRouter.of(context).go('/challenges/active-2');
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Completed', style: AppTypography.titleLarge),
            const CoinBadge(coins: 120),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GlassCard(
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
                      Text('Morning run', style: AppTypography.titleMedium),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '7 days · +120 coins',
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
        const SizedBox(height: AppSpacing.sm),
        GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: AppColors.coinGold,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No sugar', style: AppTypography.titleMedium),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '21 days · +260 coins',
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
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Create a new challenge',
          onPressed: () {
            GoRouter.of(context).go('/challenges/create');
          },
        ),
      ],
    );
  }
}

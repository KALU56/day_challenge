import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/radius.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/badges/streak_fire_badge.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/coin_badge.dart';

class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'Good morning',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Rise and crush it',
                    style: AppTypography.headlineMedium,
                  ),
                ],
              ),
            ),
            const CoinBadge(coins: 230),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('12 day streak', style: AppTypography.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              const StreakFireBadge(streak: 12),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Stay consistent and keep your streak alive.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Drink water', style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Day 12 of 21',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Private',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: const Text('Mark done'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Read 10 pages', style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Day 5 of 7',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.people_alt_outlined,
                          color: AppColors.promisePurple,
                          size: 18,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Friend',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.promisePurple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.success,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Create new challenge',
          onPressed: () {
            GoRouter.of(context).go('/challenges/create');
          },
        ),
      ],
    );
  }
}

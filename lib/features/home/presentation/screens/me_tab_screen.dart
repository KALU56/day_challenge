import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/coin_badge.dart';

class MeTabScreen extends StatelessWidget {
  const MeTabScreen({super.key});

  Widget _stickerTile({
    required String title,
    required IconData icon,
    required bool earned,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: earned
            ? AppColors.primary.withValues(alpha: 0.14)
            : AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: earned ? AppColors.primary : AppColors.darkOutline,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: earned ? AppColors.primary : AppColors.grey500,
            size: 32,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTypography.bodyMedium.copyWith(
              color: earned ? AppColors.primary : AppColors.grey500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Profile', style: AppTypography.headlineMedium),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Column(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'Y',
                    style: AppTypography.headlineMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text('Yonas', style: AppTypography.titleLarge),
              Text(
                'Consistency Champion',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GlassCard(
          child: Column(
            children: [
              const CoinBadge(coins: 230),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(label: 'Done', value: '3'),
                  _StatItem(label: 'Best streak', value: '21'),
                  _StatItem(label: 'Freezes', value: '5'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Stickers earned', style: AppTypography.titleLarge),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
          children: [
            _stickerTile(
              title: '3-Day',
              icon: Icons.emoji_events,
              earned: true,
            ),
            _stickerTile(
              title: '7-Day',
              icon: Icons.emoji_events,
              earned: true,
            ),
            _stickerTile(
              title: '21-Day',
              icon: Icons.emoji_events,
              earned: false,
            ),
            _stickerTile(
              title: '30-Day',
              icon: Icons.emoji_events,
              earned: false,
            ),
            _stickerTile(title: 'Promise', icon: Icons.favorite, earned: false),
            _stickerTile(title: 'Kind', icon: Icons.lightbulb, earned: false),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Edit profile',
          onPressed: () {
            GoRouter.of(context).go('/profile');
          },
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.headlineMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.grey500),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/challenge/view_models/challenge_list_notifier.dart';
import '../../../../features/profile/models/user_profile_model.dart';
import '../../../../features/profile/view_models/profile_notifier.dart';
import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../shared/widgets/coin_badge.dart';

class MeTabScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    final challengeState = ref.watch(challengeListProvider);

    return profileState.when(
      data: (user) {
        if (user == null) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profile', style: AppTypography.headlineMedium),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'No profile found yet.',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: 'Create demo profile',
                  onPressed: () {
                    final demo = UserProfileModel(
                      id: 'demo',
                      username: 'Player',
                      coins: 0,
                      unlockedStickers: [],
                      createdAt: DateTime.now(),
                    );
                    ref.read(profileNotifierProvider.notifier).save(demo);
                  },
                ),
              ],
            ),
          );
        }

        return challengeState.when(
          data: (challenges) {
            final completedCount = challenges
                .where((challenge) => challenge.isCompleted)
                .length;
            final bestStreak = challenges.fold<int>(
              0,
              (prev, challenge) =>
                  challenge.streak > prev ? challenge.streak : prev,
            );
            final stickers = user.unlockedStickers;

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
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            user.username.substring(0, 1).toUpperCase(),
                            style: AppTypography.headlineMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(user.username, style: AppTypography.titleLarge),
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
                      CoinBadge(coins: user.coins),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            label: 'Done',
                            value: completedCount.toString(),
                          ),
                          _StatItem(
                            label: 'Best streak',
                            value: bestStreak.toString(),
                          ),
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
                      earned: stickers.contains('3-Day'),
                    ),
                    _stickerTile(
                      title: '7-Day',
                      icon: Icons.emoji_events,
                      earned: stickers.contains('7-Day'),
                    ),
                    _stickerTile(
                      title: '21-Day',
                      icon: Icons.emoji_events,
                      earned: stickers.contains('21-Day'),
                    ),
                    _stickerTile(
                      title: '30-Day',
                      icon: Icons.emoji_events,
                      earned: stickers.contains('30-Day'),
                    ),
                    _stickerTile(
                      title: 'Promise',
                      icon: Icons.favorite,
                      earned: stickers.contains('Promise'),
                    ),
                    _stickerTile(
                      title: 'Kind',
                      icon: Icons.lightbulb,
                      earned: stickers.contains('Kind'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: 'Edit profile',
                  onPressed: () => GoRouter.of(context).go('/profile'),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) =>
              Center(child: Text('Unable to load profile stats: $error')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text('Unable to load profile: $error')),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/challenge/view_models/challenge_list_notifier.dart';
import '../../../../features/profile/view_models/profile_notifier.dart';
import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/cards/glass_card.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import '../../../../services/deep_links/deep_link_sharing_service.dart';

class SocialTabScreen extends ConsumerWidget {
  const SocialTabScreen({super.key});

  static final _sharingService = DeepLinkSharingService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);
    final challengeState = ref.watch(challengeListProvider);

    return profileState.when(
      data: (profile) {
        return challengeState.when(
          data: (challenges) {
            final activeChallenges = challenges
                .where((challenge) => !challenge.isCompleted)
                .toList();
            final sharedChallenge = activeChallenges.isNotEmpty
                ? activeChallenges.first
                : null;
            final canShare = profile != null && sharedChallenge != null;

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                Text('Community', style: AppTypography.headlineMedium),
                const SizedBox(height: AppSpacing.md),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Friend challenge', style: AppTypography.titleLarge),
                      const SizedBox(height: AppSpacing.xs),
                      Text('Read 10 pages', style: AppTypography.bodyLarge),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'You Day 5 VS Abebe Day 4',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.grey500,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.sports_martial_arts,
                            color: AppColors.promisePurple,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      GlassCard(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Abebe missed today.',
                              style: AppTypography.bodyLarge,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'They’re asking for a Promise — do double tomorrow?',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.grey500,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    onPressed: canShare
                                        ? () async {
                                            await _sharingService
                                                .sharePromiseRequest(
                                                  challengeId:
                                                      sharedChallenge.id,
                                                  senderName: profile.username,
                                                  coins: 5,
                                                );
                                          }
                                        : null,
                                    child: const Text('Accept'),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: FilledButton.tonal(
                                    onPressed: canShare
                                        ? () async {
                                            await _sharingService
                                                .shareFreezeGift(
                                                  challengeId:
                                                      sharedChallenge.id,
                                                  senderName: profile.username,
                                                );
                                          }
                                        : null,
                                    child: const Text('Reject'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      FilledButton(
                        onPressed: canShare
                            ? () async {
                                await _sharingService.shareFreezeGift(
                                  challengeId: sharedChallenge.id,
                                  senderName: profile.username,
                                );
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.freezeBlue,
                        ),
                        child: const Text('Freeze Abebe'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Join a challenge', style: AppTypography.titleLarge),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Enter join code e.g. DAY-4X9K',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      FilledButton(
                        onPressed: canShare
                            ? () async {
                                await _sharingService.shareChallengeInvite(
                                  challengeId: sharedChallenge.id,
                                  challengerName: profile.username,
                                  challengeTitle: sharedChallenge.title,
                                );
                              }
                            : null,
                        child: const Text('Join challenge'),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Your active group code',
                        style: AppTypography.labelLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'DAY-9 M2A',
                          style: AppTypography.titleLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      PrimaryButton(
                        label: 'Share via WhatsApp / Telegram',
                        onPressed: canShare
                            ? () async {
                                await _sharingService.shareChallengeInvite(
                                  challengeId: sharedChallenge.id,
                                  challengerName: profile.username,
                                  challengeTitle: sharedChallenge.title,
                                );
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Active community challenges',
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No junk food', style: AppTypography.titleMedium),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '21 days · Code: DAY-NJF21',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: const [
                            Icon(
                              Icons.group,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text('14 joined'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Morning walk', style: AppTypography.titleMedium),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '7 days · Code: DAY-WALK7',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: const [
                            Icon(
                              Icons.group,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            SizedBox(width: AppSpacing.xs),
                            Text('8 joined'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, st) =>
              Center(child: Text('Unable to load challenges: $error')),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, st) =>
          Center(child: Text('Unable to load profile: $error')),
    );
  }
}

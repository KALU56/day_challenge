import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_profile_model.dart';
import '../../view_models/profile_notifier.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);
    final notifier = ref.read(profileNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: state.when(
        data: (user) {
          if (user == null) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No profile found', style: AppTypography.headlineMedium),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: 'Create Demo Profile',
                    onPressed: () {
                      final id = const Uuid().v4();
                      final demo = UserProfileModel(
                        id: id,
                        username: 'Player',
                        coins: 0,
                        unlockedStickers: [],
                        createdAt: DateTime.now(),
                      );
                      notifier.save(demo);
                    },
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.username, style: AppTypography.displayLarge),
                const SizedBox(height: AppSpacing.md),
                Text('Coins: ${user.coins}', style: AppTypography.titleLarge),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    PrimaryButton(
                      label: 'Add 10 Coins',
                      onPressed: () async {
                        final updated = user.copyWith(coins: user.coins + 10);
                        await notifier.save(updated);
                      },
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    PrimaryButton(
                      label: 'Clear Profile',
                      onPressed: () async {
                        await notifier.clear();
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading profile')),
      ),
    );
  }
}

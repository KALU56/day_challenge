import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_models/challenge_list_notifier.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/badges/streak_fire_badge.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';

class ChallengeDetailScreen extends ConsumerWidget {
  const ChallengeDetailScreen({super.key, required this.challengeId});

  final String challengeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeListProvider);
    final notifier = ref.read(challengeListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Challenge')),
      body: state.when(
        data: (items) {
          final c = items.firstWhere((e) => e.id == challengeId);
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.title, style: AppTypography.headlineMedium),
                const SizedBox(height: AppSpacing.md),
                Text(c.description, style: AppTypography.bodyLarge),
                const SizedBox(height: AppSpacing.md),
                StreakFireBadge(streak: c.streak),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: 'Check In',
                  onPressed: () async {
                    final updated = c.copyWith(
                      streak: c.streak + 1,
                      completedDates: [...c.completedDates, DateTime.now()],
                    );
                    await notifier.update(updated);
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading challenge')),
      ),
    );
  }
}

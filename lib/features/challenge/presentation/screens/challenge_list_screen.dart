import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/challenge_model.dart';
import '../../view_models/challenge_list_notifier.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';
import 'challenge_create_screen.dart';
import 'challenge_detail_screen.dart';

class ChallengeListScreen extends ConsumerWidget {
  const ChallengeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeListProvider);
    final notifier = ref.read(challengeListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ChallengeCreateScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: state.when(
        data: (items) {
          if (items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No challenges yet',
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: 'Create sample',
                    onPressed: () async {
                      final id = const Uuid().v4();
                      final sample = ChallengeModel(
                        id: id,
                        title: 'Read 20 pages',
                        description: 'Daily reading habit',
                        durationDays: 30,
                        startDate: DateTime.now(),
                        streak: 0,
                        completedDates: [],
                        isCompleted: false,
                        reminderHour: 20,
                        reminderMinute: 0,
                      );
                      await notifier.create(sample);
                    },
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final c = items[index];
              return ListTile(
                title: Text(c.title, style: AppTypography.titleMedium),
                subtitle: Text(c.description, style: AppTypography.bodyMedium),
                trailing: Text('${c.streak}🔥'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChallengeDetailScreen(challengeId: c.id),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading challenges')),
      ),
    );
  }
}

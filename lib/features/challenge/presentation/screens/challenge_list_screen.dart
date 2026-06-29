import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view_models/challenge_list_notifier.dart';
import '../../../../design_system/tokens/colors.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/tokens/typography.dart';

class ChallengeListScreen extends ConsumerWidget {
  const ChallengeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).go('/challenges/create'),
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
                  Text(
                    'Tap the + button to create your first challenge and start tracking your streak.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.grey500,
                    ),
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
                onTap: () => GoRouter.of(context).go('/challenges/${c.id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading challenges: $e')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/challenge_model.dart';
import '../../view_models/challenge_list_notifier.dart';
import '../../../../design_system/tokens/spacing.dart';
import '../../../../design_system/widgets/inputs/custom_text_field.dart';
import '../../../../design_system/widgets/buttons/primary_button.dart';

class ChallengeCreateScreen extends ConsumerStatefulWidget {
  const ChallengeCreateScreen({super.key});

  @override
  ConsumerState<ChallengeCreateScreen> createState() =>
      _ChallengeCreateScreenState();
}

class _ChallengeCreateScreenState extends ConsumerState<ChallengeCreateScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(challengeListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Challenge')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _title,
              labelText: 'Title',
              hintText: 'e.g., Walk 5k',
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              controller: _description,
              labelText: 'Description',
              hintText: 'Short description',
            ),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'Create',
              onPressed: () async {
                final id = const Uuid().v4();
                final model = ChallengeModel(
                  id: id,
                  title: _title.text.isEmpty ? 'New Challenge' : _title.text,
                  description: _description.text.isEmpty
                      ? '...'
                      : _description.text,
                  durationDays: 7,
                  startDate: DateTime.now(),
                  streak: 0,
                  completedDates: [],
                  isCompleted: false,
                  reminderHour: 20,
                  reminderMinute: 0,
                );
                final navigator = Navigator.of(context);
                await notifier.create(model);
                if (!mounted) return;
                await navigator.maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

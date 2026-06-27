import 'package:flutter/material.dart';
import '../badges/streak_fire_badge.dart';
import '../buttons/primary_button.dart';
import '../cards/glass_card.dart';
import '../inputs/custom_text_field.dart';
import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';

class DesignSystemPreview extends StatelessWidget {
  const DesignSystemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buttons', style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                PrimaryButton(label: 'Start challenge', onPressed: () {}),
                PrimaryButton(label: 'Loading', isLoading: true, onPressed: () {}),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Inputs', style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            const CustomTextField(labelText: 'Challenge title', hintText: 'Read 20 pages'),
            const SizedBox(height: AppSpacing.xl),
            Text('Cards & Badges', style: AppTypography.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Daily Focus', style: AppTypography.titleMedium),
                      const Spacer(),
                      const StreakFireBadge(streak: 8),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('A polished foundation for challenge cards and profile stats.', style: AppTypography.bodyLarge.copyWith(color: AppColors.grey700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

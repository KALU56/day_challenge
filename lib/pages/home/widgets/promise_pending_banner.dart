import 'package:flutter/material.dart';

import '../../../app/app_color.dart';

class PromisePendingBanner extends StatelessWidget {
  const PromisePendingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkDangerBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkDanger.withValues(alpha: 0.12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: AppColors.darkDanger),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Sara promised to join “Gym streak”.',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.darkTextPrimary),
            ),
          ),
          TextButton(onPressed: () {}, child: const Text('Accept')),
          const SizedBox(width: 8),
          TextButton(onPressed: () {}, child: const Text('Reject')),
        ],
      ),
    );
  }
}

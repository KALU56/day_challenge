import 'package:flutter/material.dart';

import '../../../app/app_color.dart';

class FreezeReceivedBanner extends StatelessWidget {
  const FreezeReceivedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.darkFreezeBg,
            AppColors.darkSurface.withValues(alpha: 0.96),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          const Icon(
            Icons.ac_unit_rounded,
            color: AppColors.darkFreeze,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Sara sent you a freeze — today’s streak is safe.',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

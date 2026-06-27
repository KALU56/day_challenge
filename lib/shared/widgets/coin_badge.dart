import 'package:flutter/material.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/utils/formatters.dart';
import '../../app/app_theme.dart';
import '../../design_system/tokens/colors.dart';
import '../../design_system/tokens/radius.dart';
import '../../design_system/tokens/spacing.dart';

class CoinBadge extends StatelessWidget {
  final int coins;
  final bool animate;

  const CoinBadge({
    super.key,
    required this.coins,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeExtension = context.theme.extension<AppThemeExtension>();
    final coinColor = themeExtension?.coinColor ?? AppColors.coinGold;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: coinColor.withValues(alpha: 0.1),
        borderRadius: AppRadius.borderPill,
        border: Border.all(
          color: coinColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.monetization_on_rounded,
            color: coinColor,
            size: 18,
          ),
          const SizedBox(width: AppSpacing.xxs),
          Text(
            Formatters.formatCoinAmount(coins),
            style: context.textTheme.labelLarge?.copyWith(
              color: coinColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

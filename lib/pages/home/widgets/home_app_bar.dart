import 'package:flutter/material.dart';

import 'coin_badge.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.onGiftTap,
    required this.onNotificationTap,
  });

  final VoidCallback onGiftTap;
  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compactLayout = constraints.maxWidth < 360;

        if (compactLayout) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Challenge momentum is real.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  const CoinBadge(amount: 1240),
                  IconButton(
                    onPressed: onGiftTap,
                    icon: const Icon(Icons.card_giftcard_rounded),
                    color: theme.iconTheme.color,
                    tooltip: 'Gifts',
                  ),
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: const Icon(Icons.notifications_none_rounded),
                    color: theme.iconTheme.color,
                    tooltip: 'Notifications',
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Challenge momentum is real.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const CoinBadge(amount: 1240),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onGiftTap,
              icon: const Icon(Icons.card_giftcard_rounded),
              color: theme.iconTheme.color,
              tooltip: 'Gifts',
            ),
            IconButton(
              onPressed: onNotificationTap,
              icon: const Icon(Icons.notifications_none_rounded),
              color: theme.iconTheme.color,
              tooltip: 'Notifications',
            ),
          ],
        );
      },
    );
  }
}

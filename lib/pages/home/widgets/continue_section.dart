import 'package:flutter/material.dart';

class ContinueSection extends StatelessWidget {
  const ContinueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Text(
            'Continue',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: theme.colorScheme.secondary,
                ),
              ),
              title: Text(
                'Read 10 Pages',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.6,
                          minHeight: 6,
                          backgroundColor: theme.progressIndicatorTheme.linearTrackColor ?? Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '60%',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_circle_fill_rounded),
                color: theme.colorScheme.primary,
                iconSize: 32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32), // Bottom padding for scrollability
      ],
    );
  }
}

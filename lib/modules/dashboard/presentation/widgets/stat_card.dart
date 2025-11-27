import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String delta;
  final Color? color;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.delta,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: (color ?? Theme.of(context).colorScheme.primary)
                  .withValues(alpha: 0.12),
              child: Icon(
                icon,
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              delta,
              style: TextStyle(
                color: delta.startsWith('-') ? Colors.red : Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

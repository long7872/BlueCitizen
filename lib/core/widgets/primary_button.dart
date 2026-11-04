import 'package:flutter/material.dart';

/// Uses the FilledButton style configured in AppTheme.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      return FilledButton(onPressed: onPressed, child: Text(label));
    }

    return FilledButton.icon(
      onPressed: onPressed,
      icon: icon!,
      label: Text(label),
    );
  }
}

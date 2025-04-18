
import 'package:flutter/material.dart';
import 'package:my_desktop_app/core/widgets/my_button.dart';

class EmployeeErrorWidget extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const EmployeeErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $error',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          MyCustomButton(
            btnText: 'Retry',
            onClick: onRetry,
          ),
        ],
      ),
    );
  }
}
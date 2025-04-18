
import 'package:flutter/material.dart';
import 'package:my_desktop_app/core/widgets/my_button.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRefresh;

  const EmptyStateWidget({
    super.key,
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          MyCustomButton(
            btnText: 'Refresh',
            onClick: onRefresh,
          ),
        ],
      ),
    );
  }
}
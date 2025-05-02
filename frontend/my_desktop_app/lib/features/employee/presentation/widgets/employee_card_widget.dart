import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';
import 'package:my_desktop_app/features/employee/presentation/providers/employee_data_provider.dart';
import 'package:my_desktop_app/features/employee/presentation/providers/employee_provider.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_status_badge.dart';

class EmployeeCard extends ConsumerWidget {
  final EmployeeReadParams readParams;
  final EmployeeEntities employee;
  final VoidCallback? onStatusChanged;

  const EmployeeCard({
    super.key,
    required this.readParams,
    required this.employee,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(employeeProvider.notifier);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with name and status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                EmployeeStatusBadge(status: employee.status.name),
              ],
            ),
            const SizedBox(height: 8),

            // Email
            Row(
              children: [
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  employee.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Org ID & Role
            Wrap(
              spacing: 12,
              children: [
                Text(
                  employee.organizationId,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
                if (employee.role != null)
                  Text(
                    employee.role!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
              ],
            ),

            const SizedBox(height: 12),
            _buildActionButtons(ref, notifier, context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      WidgetRef ref, EmployeeNotifier notifier, BuildContext context) {
    void handleStatusChange(EmployeeStatus status) async {

      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Action'),
          content: Text(
              'Are you sure you want to mark this employee as ${status.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        final params = EmployeeStatusChangeParams(
          employeeId: employee.id,
          status: status,
        );
        var success = await notifier.employeeStatusChange(params);
        if (context.mounted && success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Status updated to ${status.name}'),
            ),
          );
        }
        ref.invalidate(loadEmployeeProvider(readParams));
      }
    }

    if (employee.status == EmployeeStatus.rejected) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: onStatusChanged ??
                () => handleStatusChange(EmployeeStatus.pending),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade800,
              foregroundColor: Colors.white,
            ),
            child: const Text('Set to Pending'),
          ),
        ],
      );
    }

    if (employee.status == EmployeeStatus.pending) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 8,
        children: [
          ElevatedButton(
            onPressed: onStatusChanged ??
                () => handleStatusChange(EmployeeStatus.verified),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Verify'),
          ),
          ElevatedButton(
            onPressed: onStatusChanged ??
                () => handleStatusChange(EmployeeStatus.rejected),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reject'),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

import 'package:flutter/material.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_status_badge.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeEntities employee;
  final bool showApproveButton;
  final bool showUnblockButton;
  final VoidCallback? onStatusChanged;

  const EmployeeCard({
    super.key,
    required this.employee,
    required this.showApproveButton,
    required this.showUnblockButton,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // _buildStatusChip(employee.status.name),
                EmployeeStatusBadge(status: employee.status.name)
              ],
            ),
            const SizedBox(height: 8),
            Text(
              employee.email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  employee.organizationId,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  employee.role ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  employee.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Add buttons row here
            if (showApproveButton || showUnblockButton)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showApproveButton)
                    ElevatedButton(
                      onPressed: onStatusChanged,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Approve'),
                    ),
                  if (showApproveButton && showUnblockButton)
                    const SizedBox(width: 8),
                  if (showUnblockButton)
                    ElevatedButton(
                      onPressed: onStatusChanged,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Unblock'),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
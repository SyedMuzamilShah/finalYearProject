import 'package:flutter/material.dart';
import 'package:my_desktop_app/features/task/domain/entities/task_entities.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/location_indicator_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/priority_badge_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/status_chip_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/task_completion_dialog_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/task_model.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/task_verification_dialog_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/user_avatar_widget.dart';


class TaskCard extends StatelessWidget {
  final TaskEntities taskModel;

  const TaskCard({
    super.key,
    required this.taskModel
  });

  @override
  Widget build(BuildContext context) {
    // final assignee = task.assigneeId != null
    //     ? users.firstWhere((u) => u.id == task.assigneeId,
    //         orElse: () => users.first)
    //     : null;
    final theme = Theme.of(context);

    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleCardTap(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      taskModel.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PriorityBadge(priority: TaskPriority.high),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                taskModel.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
              if (taskModel.location != null) ...[
                const SizedBox(height: 8),
                LocationIndicator(location: taskModel.location!),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  StatusChip(
                    // status: taskModel.status,
                    status: taskModel.status,
                    onStatusChange: (value){},
                  ),
                  const Spacer(),
                  // if (assignee != null) UserAvatar(user: assignee),
                  UserAvatar(user: AppUser(id: 'dfg', name: 'tes', email: 'tas')),
                  UserAvatar(user: AppUser(id: 'hello', name: 'hello', email: 'tas')),
                  UserAvatar(user: AppUser(id: 'game', name: 'game', email: 'tas')),
                ],
              ),
              
            //   if (task.status == TaskStatus.completed &&
            //       task.verifiedBy == null) ...[
            //     const SizedBox(height: 8),
            //     Text(
            //       'Pending Verification',
            //       style: TextStyle(
            //         color: Colors.orange[700],
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ] else if (task.verifiedBy != null) ...[
            //     const SizedBox(height: 8),
            //     Text(
            //       'Verified by ${_getUserName(task.verifiedBy!)}',
            //       style: TextStyle(
            //         color: Colors.green[700],
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            ],
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context) {
  //   if (!isAdmin &&
  //       task.assigneeId == currentUserId &&
  //       task.status != TaskStatus.completed) {
      // _showCompletionDialog(context);
  //   } else if (isAdmin &&
  //       task.status == TaskStatus.completed &&
  //       task.verifiedBy == null) {
      _showVerificationDialog(context);
  //   } else {
  //     onTap();
  //   }
  }

  Future<void> _showCompletionDialog(BuildContext context) async {
    final result = await showDialog<TaskEntities>(
      context: context,
      builder: (context) => TaskCompletionDialog(
        task: taskModel,
        currentUserId: taskModel.adminId,
        // task: task,
        // currentUserId: currentUserId,
      ),
    );
    if (result != null) {
      // onTaskCompletion(result);
    }
  }

  Future<void> _showVerificationDialog(BuildContext context) async {
    final verified = await showDialog<bool>(
      context: context,
      builder: (context) => TaskVerificationDialog(
        task: taskModel,
        currentUserId: taskModel.adminId,
      ),
    );
    // if (verified != null) {
      // onTaskVerification(task, verified);
  //   }
  }

  // String _getUserName(String userId) {
  //   try {
  //     return users.firstWhere((user) => user.id == userId).name;
  //   } catch (e) {
  //     return 'Admin';
  //   }
  // }
}

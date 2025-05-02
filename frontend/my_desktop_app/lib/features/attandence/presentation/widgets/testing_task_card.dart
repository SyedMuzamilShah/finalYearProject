// import 'package:flutter/material.dart';

// class TaskAssignmentCard extends StatelessWidget {
//   const TaskAssignmentCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // --- Static sample data ---
//     final taskTitle = "Deliver Documents";
//     final taskDescription = "Deliver important documents to the client before 5 PM.";
//     final dueDate = DateTime.now().add(const Duration(days: 1));
//     final address = "123 Main Street, City Center";
//     final status = "VERIFIED"; // You can show color based on status if you want
//     final submittedLate = false;
//     final faceVerificationRequired = true;

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       elevation: 6,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title + Status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   taskTitle,
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: getStatusColor(status),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     status,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             // Description
//             Text(
//               taskDescription,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 12),
//             // Due date and address
//             Row(
//               children: [
//                 const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
//                 const SizedBox(width: 4),
//                 Text(
//                   "Due: ${formatDate(dueDate)}",
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 18, color: Colors.grey),
//                 const SizedBox(width: 4),
//                 Expanded(
//                   child: Text(
//                     address,
//                     style: const TextStyle(color: Colors.grey),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             // Face verification & Late submission
//             Row(
//               children: [
//                 if (faceVerificationRequired)
//                   const Chip(
//                     label: Text('Face Verification Required'),
//                     avatar: Icon(Icons.face, size: 16),
//                     backgroundColor: Colors.orangeAccent,
//                   ),
//                 const SizedBox(width: 8),
//                 // if (submittedLate)
//                   const Chip(
//                     label: Text('Submitted Late'),
//                     avatar: Icon(Icons.warning, size: 16),
//                     backgroundColor: Colors.redAccent,
//                   ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Interaction buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (status == 'ASSIGNED')
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Action: Mark Completed
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Task marked as completed')),
//                     );
//                   },
//                   icon: const Icon(Icons.check),
//                   label: const Text("Complete"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                   ),
//                 ),

//                 if (status == 'ASSIGNED' || status == 'SUBMITTED')
//                 OutlinedButton.icon(
//                   onPressed: () {
//                     // Action: Report Issue
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Issue reported')),
//                     );
//                   },
//                   icon: const Icon(Icons.report_problem),
//                   label: const Text("Report"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Color getStatusColor(String status) {
//     switch (status) {
//       case "ASSIGNED":
//         return Colors.blueAccent;
//       case "COMPLETED":
//         return Colors.green;
//       case "VERIFIED":
//         return Colors.purple;
//       case "SUBMITTED":
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }

//   String formatDate(DateTime date) {
//     return "${date.day}/${date.month}/${date.year}";
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskDashboardScreen extends StatelessWidget {
  const TaskDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          TaskCard(
            task: Task(
              id: '1',
              title: 'Inventory Check',
              description: 'Verify all items in warehouse A',
              dueDate: DateTime.now().add(const Duration(days: 2)),
              status: 'ASSIGNED',
              location: Location(
                coordinates: [77.5946, 12.9716],
                address: 'Warehouse A, Bangalore'
              ),
              aroundDistanceMeter: 1000,
            ),
            assignment: TaskAssignment(
              employeeName: 'John Doe',
              assingedDate: DateTime.now().subtract(const Duration(days: 1)),
              deadline: DateTime.now().add(const Duration(days: 2)),
              status: 'ASSIGNED',
              validateMethod: null,
              submittedAt: null,
              submittedLate: false,
              faceVerification: true,
              pictureAllowed: false,
            ),
          ),
          TaskCard(
            task: Task(
              id: '2',
              title: 'Customer Visit',
              description: 'Meet with client to discuss requirements',
              dueDate: DateTime.now().add(const Duration(days: 1)),
              status: 'COMPLETED',
              location: Location(
                coordinates: [77.5925, 12.9724],
                address: 'Client Office, MG Road'
              ),
              aroundDistanceMeter: 500,
            ),
            assignment: TaskAssignment(
              employeeName: 'Jane Smith',
              // assignedDate: DateTime.now().subtract(const Duration(days: 2)),
              assingedDate: DateTime.now().subtract(const Duration(days: 2)),
              deadline: DateTime.now().add(const Duration(hours: 12)),
              status: 'VERIFIED',
              validateMethod: 'AUTO',
              submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
              submittedLate: false,
              faceVerification: true,
              pictureAllowed: true,
              imageUrl: 'https://example.com/images/task2.jpg',
            ),
          ),
        ],
      );
  }
}

class TaskCard extends StatefulWidget {
  final Task task;
  final TaskAssignment assignment;

  const TaskCard({
    super.key,
    required this.task,
    required this.assignment,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(widget.assignment.status),
                ],
              ),
              const SizedBox(height: 8),
              
              // Basic info
              Text(
                widget.task.description,
                maxLines: _isExpanded ? null : 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              
              Row(
                children: [
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 4),
                  Text(widget.assignment.employeeName),
                  const Spacer(),
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(DateFormat('MMM dd').format(widget.task.dueDate)),
                ],
              ),
              
              // Expanded details
              if (_isExpanded) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                
                // Task Details Section
                _buildDetailSection(
                  title: 'Task Details',
                  children: [
                    _buildDetailRow('Location', widget.task.location.address),
                    _buildDetailRow('Radius', '${widget.task.aroundDistanceMeter} meters'),
                    _buildDetailRow('Created', DateFormat.yMMMd().format(widget.assignment.assingedDate)),
                  ],
                ),
                
                // Assignment Details Section
                _buildDetailSection(
                  title: 'Assignment Details',
                  children: [
                    _buildDetailRow('Assigned To', widget.assignment.employeeName),
                    _buildDetailRow('Deadline', DateFormat.yMMMd().add_jm().format(widget.assignment.deadline)),
                    if (widget.assignment.submittedAt != null)
                      _buildDetailRow(
                        'Submitted', 
                        // '${DateFormat.yMMMd().add_jm().format(widget.assignment.submittedAt)} '
                        '${DateFormat.yMMMd().add_jm().format(widget.assignment.submittedAt!)} '
                        '${widget.assignment.submittedLate ? '(Late)' : '(On Time)'}'
                      ),
                    if (widget.assignment.validateMethod != null)
                      _buildDetailRow('Verified', widget.assignment.validateMethod == 'AUTO' ? 'Automatically' : 'Manually'),
                  ],
                ),
                
                // Action Buttons
                if (widget.assignment.status == 'SUBMITTED') 
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _verifyTask(context, false),
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _verifyTask(context, true),
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                
                // View Image if available
                if (widget.assignment.imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () => _viewImage(context, widget.assignment.imageUrl!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.assignment.imageUrl!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            color: Colors.grey[200],
                            child: const Center(child: Text('Could not load image')),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case 'ASSIGNED':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        break;
      case 'SUBMITTED':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        break;
      case 'VERIFIED':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'REJECTED':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
    }
    
    return Chip(
      label: Text(
        status,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildDetailSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _verifyTask(BuildContext context, bool approved) {
    // Implement verification logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(approved ? 'Approve Task?' : 'Reject Task?'),
        content: Text(approved 
          ? 'This will mark the task as verified.' 
          : 'This will reject the task submission.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Call API to update status
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(approved 
                  ? 'Task approved successfully' 
                  : 'Task rejected')),
              );
            },
            child: Text(approved ? 'Approve' : 'Reject'),
          ),
        ],
      ),
    );
  }

  void _viewImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 3.0,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: const Center(child: Text('Could not load image')),
            ),
          ),
        ),
      ),
    );
  }
}

// Data Models
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String status;
  final Location location;
  final int aroundDistanceMeter;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.location,
    required this.aroundDistanceMeter,
  });
}

class TaskAssignment {
  final String employeeName;
  final DateTime assingedDate;
  final DateTime deadline;
  final String status;
  final String? validateMethod;
  final DateTime? submittedAt;
  final bool submittedLate;
  final bool faceVerification;
  final bool pictureAllowed;
  final String? imageUrl;

  TaskAssignment({
    required this.employeeName,
    required this.assingedDate,
    required this.deadline,
    required this.status,
    this.validateMethod,
    this.submittedAt,
    required this.submittedLate,
    required this.faceVerification,
    required this.pictureAllowed,
    this.imageUrl,
  });
}

class Location {
  final List<double> coordinates;
  final String address;

  Location({
    required this.coordinates,
    required this.address,
  });
}
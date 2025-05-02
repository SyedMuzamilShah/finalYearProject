import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_desktop_app/core/widgets/date_select_widget.dart';
import 'package:my_desktop_app/features/attandence/presentation/widgets/create_task_state.dart';

class BasicInformationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final CreateTaskState taskState;

  const BasicInformationForm({required this.formKey, required this.taskState, super.key});

  @override
  State<BasicInformationForm> createState() => _BasicInformationFormState();
}

class _BasicInformationFormState extends State<BasicInformationForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.taskState.title);
    _descriptionController = TextEditingController(text: widget.taskState.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title*', hintText: 'Enter task title'),
              validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
              onChanged: (value) => widget.taskState.title = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description', hintText: 'Enter task description', alignLabelWithHint: true),
              onChanged: (value) => widget.taskState.description = value,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                DateTime? selectedDate = await selectDueDate(context);
                if (selectedDate != null) {
                  setState(() {
                    widget.taskState.dueDate = selectedDate;
                  });
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Due Date*',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.taskState.dueDate == null
                          ? 'Select due date'
                          : DateFormat('MMM dd, yyyy - hh:mm a').format(widget.taskState.dueDate!),
                    ),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

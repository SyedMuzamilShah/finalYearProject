// import 'package:flutter/material.dart';
// import '../widgets/pdf_picker_widget.dart';

// class StepBasicInfo extends StatelessWidget {
//   const StepBasicInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<CreateTaskController>(context);
//     return Form(
//       key: controller.formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             controller: controller.titleController,
//             decoration: const InputDecoration(labelText: 'Task Title*'),
//             validator: (value) => (value == null || value.isEmpty) ? 'Enter title' : null,
//             onChanged: controller.updateTitle,
//           ),
//           const SizedBox(height: 16),
//           TextFormField(
//             controller: controller.descriptionController,
//             decoration: const InputDecoration(labelText: 'Description'),
//             maxLines: 3,
//             onChanged: controller.updateDescription,
//           ),
//           const SizedBox(height: 16),
//           PdfPickerWidget(), // 📝 For picking pdfs
//         ],
//       ),
//     );
//   }
// }

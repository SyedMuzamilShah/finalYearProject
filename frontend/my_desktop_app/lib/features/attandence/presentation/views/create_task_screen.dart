// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // (Riverpod can be applied later easily)
// import '../application/create_task_controller.dart';
// import 'steps/step_basic_info.dart';
// import 'steps/step_location_info.dart';
// import 'steps/step_assign_employees.dart';
// import 'steps/step_review_task.dart';
// import 'steps/step_finalize.dart';

// class CreateTaskScreen extends StatelessWidget {
//   const CreateTaskScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => CreateTaskController(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create New Task'),
//         ),
//         body: Consumer<CreateTaskController>(
//           builder: (context, controller, _) {
//             return Column(
//               children: [
//                 _StepperHeader(controller: controller),
//                 Expanded(
//                   child: _StepperContent(controller: controller),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class _StepperHeader extends StatelessWidget {
//   final CreateTaskController controller;
//   const _StepperHeader({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       currentStep: controller.currentStep,
//       type: StepperType.horizontal,
//       controlsBuilder: (context, details) => const SizedBox.shrink(),
//       onStepTapped: controller.updateStep,
//       steps: const [
//         Step(title: Text('Basic'), content: SizedBox()),
//         Step(title: Text('Location'), content: SizedBox()),
//         Step(title: Text('Assign'), content: SizedBox()),
//         Step(title: Text('Review'), content: SizedBox()),
//         Step(title: Text('Final'), content: SizedBox()),
//       ],
//     );
//   }
// }

// class _StepperContent extends StatelessWidget {
//   final CreateTaskController controller;
//   const _StepperContent({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return IndexedStack(
//       index: controller.currentStep,
//       children: const [
//         StepBasicInfo(),
//         StepLocationInfo(),
//         StepAssignEmployees(),
//         StepReviewTask(),
//         StepFinalize(),
//       ],
//     );
//   }
// }

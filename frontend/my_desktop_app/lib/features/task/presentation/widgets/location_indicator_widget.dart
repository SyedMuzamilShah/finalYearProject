
import 'package:flutter/material.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_prams.dart';
// import 'package:my_desktop_app/features/task/presentation/widgets/task_model.dart';

class LocationIndicator extends StatelessWidget {
  // final TaskLocation location;
  final LocationModel location;

  const LocationIndicator({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16, color: Colors.blue),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location.address ?? '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
          // child: Text('${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapViewWidget extends StatefulWidget {
//   const MapViewWidget({super.key});

//   @override
//   State<MapViewWidget> createState() => _MapViewWidgetState();
// }

// class _MapViewWidgetState extends State<MapViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return FlutterMap( 
//       options: MapOptions(
//         // center: const LatLng(37.7749, -122.4194),
//         initialCenter: const LatLng(37.7749, -122.4194),
//         // zoom: 10.0,
//         initialZoom: 10.0,
//         onTap: (_, latLng) {
//           setState(() {
//             _selectedLocation = latLng;
//           });
//         },
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//           userAgentPackageName: 'com.example.task_manager',
//         ),
//         MarkerLayer(
//           markers: _filteredTasks.where((t) => t.location != null).map((task) {
//             return Marker(
//               point: task.location!.toLatLng(),
//               width: 80,
//               height: 80,
//               child: GestureDetector(
//                 onTap: () => _showTaskDetails(context, task),
//                 child: Column(
//                   children: [
//                     PriorityBadge(priority: task.priority),
//                     Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             spreadRadius: 1,
//                           )
//                         ],
//                       ),
//                       child: Text(
//                         task.title,
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         if (_selectedLocation != null)
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: _selectedLocation!,
//                 width: 40,
//                 height: 40,
//                 child: const Icon(
//                   Icons.location_pin,
//                   color: Colors.red,
//                   size: 40,
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }
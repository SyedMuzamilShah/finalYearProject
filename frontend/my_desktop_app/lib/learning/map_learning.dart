import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapLearning extends ConsumerStatefulWidget {
  const MapLearning({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapLearningState();
}

class _MapLearningState extends ConsumerState<MapLearning> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(30.1834, 66.9987),
          initialZoom: 13.0,
          interactionOptions: InteractionOptions(flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
        ),
        children: [
          TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
      
          // 🔴 Radius Circles
          CircleLayer(
      circles: [
        CircleMarker(
          point: LatLng(30.1834, 66.9987),
          color: Colors.red.withOpacity(0.3),
          borderColor: Colors.red,
          borderStrokeWidth: 0.2,
          useRadiusInMeter: true,
          radius: 1000, // Radius in meters
        ),
        CircleMarker(
          point: LatLng(30.1834, 66.9087),
          color: Colors.blue.withOpacity(0.3),
          borderColor: Colors.blue,
          borderStrokeWidth: 0.2,
          useRadiusInMeter: true,
          radius: 2000, // You can change the radius for each
        ),
      ],
          ),
      
          // 📍 Markers
          MarkerLayer(
      markers: [
        Marker(
          point: LatLng(30.1834, 66.9987),
          child: Icon(Icons.location_on, color: Colors.red, size: 20),
        ),
        Marker(
          point: LatLng(30.1834, 66.9087),
          child: Icon(Icons.location_on, color: Colors.blue, size: 20),
        ),
      ],
          ),
        ],
      )
    );
  }
}
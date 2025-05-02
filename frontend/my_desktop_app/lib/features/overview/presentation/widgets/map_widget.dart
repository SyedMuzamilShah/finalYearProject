import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_desktop_app/core/widgets/my_dialog_box.dart';

enum Difficulty { easy, medium, hard }

class MapWidget extends StatefulWidget {
  final Color primaryColor;
  const MapWidget({super.key, required this.primaryColor});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();

  final List<Map<String, dynamic>> locations = [
    {
      'name': 'Location A',
      'latLng': LatLng(30.1834, 66.9987),
      'difficulty': Difficulty.easy,
    },
    {
      'name': 'Location B',
      'latLng': LatLng(30.5, 67.1),
      'difficulty': Difficulty.medium,
    },
    {
      'name': 'Location C',
      'latLng': LatLng(30.8, 66.5),
      'difficulty': Difficulty.hard,
    },
  ];

  Color _markerColor(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return Colors.green;
      case Difficulty.medium:
        return Colors.orange;
      case Difficulty.hard:
        return Colors.red;
    }
  }

  void _focusLocation(LatLng latLng) {
    _mapController.move(latLng, 10.0);
  }

  void _showFullScreenMap(BuildContext context) {
    showMyDialog(
      context,
      Stack(
        children: [
          FlutterMap(
            mapController: MapController(),
            options: MapOptions(
              initialCenter: const LatLng(30.1834, 66.9987),
              initialZoom: 6.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.task_manager',
              ),
              MarkerLayer(
                markers: locations.map((location) {
                  return Marker(
                    width: 40,
                    height: 40,
                    point: location['latLng'],
                    child: Icon(
                      Icons.location_on,
                      color: _markerColor(location['difficulty']),
                      size: 30,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.close,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(30.1834, 66.9987),
                initialZoom: 6.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.task_manager',
                ),
                MarkerLayer(
                  markers: locations.map((location) {
                    return Marker(
                      width: 40,
                      height: 40,
                      point: location['latLng'],
                      child: Icon(
                        Icons.location_on,
                        color: _markerColor(location['difficulty']),
                        size: 30,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: [
                FloatingActionButton.small(
                  backgroundColor: widget.primaryColor,
                  onPressed: () => _showFullScreenMap(context),
                  child: const Icon(Icons.fullscreen, color: Colors.white),
                ),
                const SizedBox(height: 8),
                ...locations.map((loc) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: ElevatedButton(
                      onPressed: () => _focusLocation(loc['latLng']),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _markerColor(loc['difficulty']),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: Text(
                        loc['name'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

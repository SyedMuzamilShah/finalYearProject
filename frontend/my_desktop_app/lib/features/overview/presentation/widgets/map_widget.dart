import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapWidget extends StatelessWidget {
  final Color primaryColor;
  const MapWidget({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SfMaps(
              layers: [
                MapTileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  initialFocalLatLng: const MapLatLng(30.183270, 66.996452),
                  initialZoomLevel: 15,
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton.small(
              backgroundColor: primaryColor,
              onPressed: () {},
              child: const Icon(Icons.fullscreen, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

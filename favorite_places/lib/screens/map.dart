import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.initialLocation = const LatLng(15.415, 36.3877),
    this.isSelecting = false,
  });

  final LatLng initialLocation;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _saveLocatoin() {
    Navigator.of(context).pop(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick Your Location' : 'Your Location',
        ),
        actions: !widget.isSelecting
            ? []
            : [
                IconButton(onPressed: _saveLocatoin, icon: Icon(Icons.save)),
              ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.initialLocation,
          zoom: 16,
        ),
        onTap: widget.isSelecting
            ? (latLng) => setState(() => _pickedLocation = latLng)
            : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ?? widget.initialLocation,
                ),
              },
      ),
    );
  }
}

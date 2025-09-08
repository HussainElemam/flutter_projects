import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation) onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  var _isGettingLocation = false;
  PlaceLocation? _placeLocation;

  String get imagePreview {
    final lat = _placeLocation!.latitude;
    final lng = _placeLocation!.longitude;

    final imageUrl =
        'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=${dotenv.env['MAPS_API_KEY']}';
    return imageUrl;
  }

  void _getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lng = locationData.longitude;
    final lat = locationData.latitude;

    if (lng == null || lat == null) return;

    _saveLocatoin(lat, lng);
  }

  void _selectLocation() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) return;

    _saveLocatoin(selectedLocation.latitude, selectedLocation.longitude);
  }

  void _saveLocatoin(double lat, double lng) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${dotenv.env['MAPS_API_KEY']}',
    );

    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _placeLocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_placeLocation!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
            ),
          ),
          child: _isGettingLocation
              ? CircularProgressIndicator()
              : _placeLocation != null
              ? Image.network(
                  imagePreview,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No location is chosen',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getLocation,
              label: Text('Get Current Location'),
              icon: Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: _selectLocation,
              label: Text('Select on Map'),
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}

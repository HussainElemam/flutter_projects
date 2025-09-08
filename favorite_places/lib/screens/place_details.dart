import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.place,
  });

  final Place place;

  String get imagePreview {
    final lat = place.location.latitude;
    final lng = place.location.longitude;

    final imageUrl =
        'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=${dotenv.env['MAPS_API_KEY']}';
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                            initialLocation: LatLng(
                              place.location.latitude,
                              place.location.longitude,
                            ),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          imagePreview,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

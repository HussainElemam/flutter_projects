import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? Center(
            child: Text(
              'There are no places yet.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (ctx, index) => ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(places[index].image),
              ),
              title: Text(
                places[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                places[index].location.address,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PlaceScreen(place: places[index]),
                  ),
                );
              },
            ),
          );
  }
}

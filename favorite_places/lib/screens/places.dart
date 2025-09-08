import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _getPlaces;
  @override
  void initState() {
    super.initState();
    _getPlaces = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  void _addPlace() {
    Navigator.of(
      context,
    ).push(
      MaterialPageRoute(
        builder: (context) => AddPlaceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Place> placesList = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: _addPlace,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getPlaces,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : PlacesList(places: placesList),
      ),
    );
  }
}

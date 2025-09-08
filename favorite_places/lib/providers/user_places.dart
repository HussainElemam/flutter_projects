import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favorite_places/models/place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address String)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();

    final placesData = await db.query('user_places');
    final places = placesData
        .map(
          (place) => Place(
            title: place['title'] as String,
            image: File(place['image'] as String),
            location: PlaceLocation(
              latitude: place['lat'] as double,
              longitude: place['lng'] as double,
              address: place['address'] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    state = [newPlace, ...state];
  }

  void removePlace(Place place) {
    state = state.where((item) => item.id != place.id).toList();
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
      (ref) => UserPlacesNotifier(),
    );

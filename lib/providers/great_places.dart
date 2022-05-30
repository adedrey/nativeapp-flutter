import 'package:flutter/material.dart';
import 'dart:io';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toIso8601String(),
        title: title,
        location: updatedLocation,
        image: image);
    _items.insert(0, newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': updatedLocation.latitude,
        'loc_long': updatedLocation.longitude,
        'address': updatedLocation.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_long'],
                address: place['address']),
            image: File(place['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}

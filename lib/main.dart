import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/place_detail_screen.dart';
import './screens/places_list_screen.dart';
import './providers/great_places.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GreatPlaces(),
        ),
      ],
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        // home: ...,
        routes: {
          '/': (context) => PlacesListScreen(),
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}

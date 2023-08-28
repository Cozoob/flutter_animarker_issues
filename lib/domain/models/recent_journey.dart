import 'package:google_maps_flutter/google_maps_flutter.dart';

// TODO COMMENT
class RecentJourney {
  final String departureName;
  final String destinationName;
  final LatLng departureCoords;
  final LatLng destinationCoords;

  RecentJourney({
    required this.departureName,
    required this.destinationName,
    required this.departureCoords,
    required this.destinationCoords
  });
}
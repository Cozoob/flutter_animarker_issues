import 'package:google_maps_flutter/google_maps_flutter.dart';

class Stop {
  final LatLng latLng;
  final String name;

  Stop({
    required this.latLng,
    required this.name,
  });
}

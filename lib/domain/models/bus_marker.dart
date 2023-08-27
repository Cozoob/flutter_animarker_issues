import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusMarker extends Equatable {
  final MarkerId markerId;
  final LatLng position;
  final Marker marker;

  const BusMarker({
    required this.markerId,
    required this.position,
    required this.marker
  });

  @override
  List<Object?> get props => [markerId, position];
}
import 'package:city_transit/data/datasources/recent_journeys_source.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:city_transit/domain/models/stop.dart';

class HomeScreenProvider extends ChangeNotifier {
  bool _showTraffic = false;
  bool get showTraffic => _showTraffic;

  changeTrafficValue() {
    _showTraffic = !_showTraffic;
    notifyListeners();
  }

  // HOME SCREEN MARKERS
  final Set<Marker> _homeScreenMarkers = {};
  Set<Marker> get homeScreenMarkers => _homeScreenMarkers;

  buildRouteHomeScreen(LatLng departureLatLng, LatLng destinationLatLng) async {
    // TODO IN THE FUTURE PERFORM OUR REQUEST AND BUILD IN OUR ALGO TO GET POSSIBLE ROUTES
    // IT HAS TO RETURN EVERYTHING WE SHOULD HAVE TO AVOID THESE ADDITIONAL REQUEST THAT ARE BELOW

    // to delete in the future ;):
    List<LatLng> coordinates = [departureLatLng];
    // FAKE AND ONLY VALID FOR DEPARTURE: Chelmonskiego Petla DESTINATION: Miasteczko Studenckie AGH
    coordinates.addAll(
      [
        const LatLng(50.093840, 19.892729), // Stawowa
        const LatLng(50.086621, 19.891096), // Rondo Ofiar Katynia
        const LatLng(50.080985, 19.890482), // Bronowice SKA
        const LatLng(50.076596, 19.888746), // Zarzecze
        const LatLng(50.070660, 19.899235), // Przybyszewskiego
      ]
    );
    coordinates.add(destinationLatLng);

    List<Stop> stops = [];
    for(LatLng coord in coordinates) {
      String name = await RecentJourneysSource.searchLocationName(coord);
      stops.add(
        Stop(
            latLng: coord,
            name: name
        )
      );
    }

    _homeScreenMarkers.clear();
    // Departure marker
    _homeScreenMarkers.add(
        Marker(
          markerId: const MarkerId('departure'),
          position: departureLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: stops.first.name),
        ),
    );
    // Stops markers
    for(int i = 1; i < stops.length - 1; i++) {
      _homeScreenMarkers.add(
        Marker(
          markerId: MarkerId('stop_$i'),
          position: stops[i].latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: InfoWindow(title: stops[i].name),
        )
      );
    }
    // Destination marker
    _homeScreenMarkers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: destinationLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: stops.last.name),
        )
    );
    //notifyListeners(); // it is even needed?
  }

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  addMarker() {
    _markers.add(
      const Marker(
          markerId: MarkerId('default location'),
        position: LatLng(
            50.061733,
            19.935639
        ),
        icon: BitmapDescriptor.defaultMarker
      )
    );
    notifyListeners();
  }
}
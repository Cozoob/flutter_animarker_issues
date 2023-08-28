import 'package:geocoding/geocoding.dart';
import 'package:city_transit/domain/models/recent_journey.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecentJourneysSource {
  static final locationsNames = [
    ["Chełmońskiego Pętla", "Miasteczko Studenckie AGH"],
    ["Miasteczko Studenckie AGH", "Rondo Matecznego"],
    ["AGH / UR", "Wieliczka Kopalnia Soli"],
    ["Bonarka City Center", "Prokocim Szpital"],
    ["Kawiory", "Plac Inwalidów"],
    ["Plac Inwalidów", "Bociana"],
    ["Szpital Narutowicza", "Poczta Główna"],
    ["Starowiślna", "Jubilat"]
  ];

  static const String cityName = 'Kraków';

  static Future<List<RecentJourney>> getLocations() async {
    List<RecentJourney> recentJourneys = [];
    for(List<String> locations in locationsNames) {
      List<Location> departureLoc = await searchLocation('${locations[0]} $cityName');
      List<Location> destinationLoc = await searchLocation('${locations[1]} $cityName');
      if(departureLoc.isNotEmpty && destinationLoc.isNotEmpty) {
        LatLng departureLatLng = LatLng(
            departureLoc.first.latitude,
            departureLoc.first.longitude
        );
        LatLng destinationLatLng = LatLng(
            destinationLoc.first.latitude,
            destinationLoc.first.longitude
        );
        recentJourneys.add(
            RecentJourney(
                departureName: locations[0],
                destinationName: locations[1],
                departureCoords: departureLatLng,
                destinationCoords: destinationLatLng
            )
        );
      }
    }
    return recentJourneys;
  }


  // Function to perform geocoding and set the selected location on the map
  static Future<List<Location>> searchLocation(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      try {
        return await locationFromAddress(searchQuery);
      } catch (e) {
        // TODO SOMETHING
        print('Error occurred while geocoding: $e');
      }
    }
    return [];
  }

  // Function to perform fetching name
  static Future<String> searchLocationName(LatLng searchLatLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(searchLatLng.latitude, searchLatLng.longitude);
      if(placemarks.isEmpty) {
        return '';
      }
      return placemarks[0].name!;
    } catch (e) {
      // TODO SOMETHING
      print('Error occurred while geocoding: $e');
      return '';
    }
  }
}
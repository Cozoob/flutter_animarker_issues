import 'dart:math';
import 'dart:async';

import 'package:city_transit/data/providers/home_provider.dart';
import 'package:city_transit/data/providers/map_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Represents the map wrapper for the main map with different modes in app.
class MapWrapper extends StatefulWidget {
  static const LatLng _defaultLatLng = LatLng(50.061733, 19.935639);
  static const double _defaultZoom = 12.0;
  static const refreshMarkersDuration  = Duration(seconds: 2);

  const MapWrapper({super.key});

  @override
  _MapWrapperState createState() => _MapWrapperState();
}

class _MapWrapperState extends State<MapWrapper> {

  bool showChosenRoute = false;
  bool showAllVehicles = true;
  late CameraPosition currCameraPosition = _defaultLocation;
  late String mapMode = 'HOME';
  GoogleMapController? _mapController;
  final _completeMapController = Completer<GoogleMapController>();
  final List<LatLng> _routeCoordinates = [];
  late LatLng departureLatLng;
  late LatLng destinationLatLng;
  // late Set<Marker> markers = {};
  final markers = <MarkerId, Marker>{};
  late Set<Marker> homeScreenMarkers = {};
  late Set<Polyline> polylines = {};
  late bool trafficEnabled = false;

  @override
  void initState() {
    super.initState();
    _generateRouteCoordinates();

    // fake bus data
    Timer.periodic(const Duration(seconds: 10), (_) {
      _updateBusLocations();
    });
  }

  // HELP STACKOVERFLOW
  // https://stackoverflow.com/questions/57415617/how-to-access-to-provider-field-from-class-that-do-not-have-context
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapMode = Provider.of<MapModeProvider>(context, listen: false).mode;

    switch(mapMode) {
      case 'HOME': { // instead of HOME change to CLEARED map mode? tbd
        if(_mapController != null){
          _clearMap();
          showAllVehicles = true;
          showChosenRoute = false;
          break;
        }
      }
      case 'RECENT_JOURNEY_BOX': {
        showAllVehicles = true;
        showChosenRoute = true;
        trafficEnabled = Provider.of<HomeScreenProvider>(context, listen: false).showTraffic;
        homeScreenMarkers = Provider.of<HomeScreenProvider>(context, listen: false).homeScreenMarkers;
        departureLatLng = homeScreenMarkers.first.position;
        destinationLatLng = homeScreenMarkers.last.position;
        _generateRouteCoordinates();
        _adjustCameraPosition();
        break;
      }
      default: {
        if(_mapController != null) _clearMap();
      }
    }

    _updateAllMarkers();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<MapModeProvider>().mode;

    return Animarker(
      shouldAnimateCamera: false,
      curve: Curves.easeInOutExpo,
      rippleRadius: 0.2,
      // duration: const Duration(microseconds: 10),
      duration: const Duration(seconds: 50),
      mapId: _completeMapController.future
          .then<int>((value) => value.mapId),
      markers: markers.values.toSet(),

      child: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
          _completeMapController.complete(controller);
        },
        initialCameraPosition: _defaultLocation,
        zoomControlsEnabled: false,
        trafficEnabled: trafficEnabled,
        polylines: polylines,
        onTap: (coord) => print("Tapped on location: $coord"),
      ),
    );
  }

  static const CameraPosition _defaultLocation = CameraPosition(
      target: MapWrapper._defaultLatLng,
      zoom: MapWrapper._defaultZoom
  );

  void _adjustCameraPosition() async {
    double southwestLatitude = departureLatLng.latitude,
        southwestLongitude = departureLatLng.longitude,
        northeastLatitude = destinationLatLng.latitude,
        northeastLongitude = destinationLatLng.longitude;

    for(Marker marker in homeScreenMarkers) {
      southwestLatitude = min(southwestLatitude, marker.position.latitude);
      southwestLongitude = min(southwestLongitude, marker.position.longitude);
      northeastLatitude = max(northeastLatitude, marker.position.latitude);
      northeastLongitude = max(northeastLongitude, marker.position.longitude);
    }

    final LatLng southwest = LatLng(southwestLatitude, southwestLongitude,);

    final LatLng northeast = LatLng(northeastLatitude, northeastLongitude,);

    LatLngBounds bounds = LatLngBounds(
      southwest: southwest,
      northeast: northeast,
    );
    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }

  void _generateRouteCoordinates() {
    List<LatLng> points = [];
    for(Marker marker in homeScreenMarkers) {
      points.add(marker.position);
    }

    _routeCoordinates.clear();
    _routeCoordinates.addAll(points);
    polylines = _createPolylines();
  }

  Set<Polyline> _createPolylines() {
    Set<Polyline> polylines = {};

    // Create a Polyline instance to represent the route
    polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: _routeCoordinates,
      color: Colors.blue,
      width: 3,
    ));

    return polylines;
  }

  void _clearMap() {
    trafficEnabled = false;
    markers.clear();
    polylines.clear();
    _mapController!.animateCamera(CameraUpdate.newLatLngZoom(_defaultLocation.target, _defaultLocation.zoom));
  }

  // Mock bus data for demonstration purposes
  final Map<String, Map<String, dynamic>> _busData = {
    "ID_BUS_1" : {
      "lat": 50.0647,
      "lng": 19.9362
    },
   // Add more buses here
  };

  final List<Marker> _vehiclesMarkers = [];

  final List<LatLng> _fakeNewBusPositions = const [
    LatLng(50.070224, 19.903174),
    LatLng(50.071381, 19.895688),
    LatLng(50.072458, 19.888634),
    LatLng(50.074289, 19.888228),
    LatLng(50.075753, 19.888757),
    LatLng(50.078740, 19.889772),
    LatLng(50.080673, 19.890447),
    LatLng(50.083600, 19.891078),
    LatLng(50.086618, 19.891536),
    LatLng(50.088182, 19.892221),
    LatLng(50.091733, 19.893449),
    LatLng(50.094153, 19.893088),
    LatLng(50.093657, 19.895415),
    LatLng(50.093164, 19.897726),
    LatLng(50.093515, 19.897516),
  ];

  var changeValueFakeBustData = 1;
  var currentIndexFakeBusData = 0;

  Future<void> _updateBusLocations() async {

    // TODO
    // Replace this with gRPC call
    // final response = ...;
    // if (response.statusCode == 200) {
    //   setState(() {
    //     ..
    //   });
    // }

    // for each id of the bus from response...
    const busId1 = "ID_BUS_1";
    if(!_busData.containsKey(busId1)) {
      // TODO add new data
    } else {
      _busData.forEach((busId, busInfo) {
        busInfo["lat"] = _fakeNewBusPositions[currentIndexFakeBusData].latitude;
        busInfo["lng"] = _fakeNewBusPositions[currentIndexFakeBusData].longitude;
      });
    }

    _vehiclesMarkers.clear();
    _busData.forEach((busId, busInfo) {
      _vehiclesMarkers.add(
          Marker(
              markerId: MarkerId(busId),
              position: LatLng(busInfo["lat"], busInfo["lng"]),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
          )
      );
    });

    setState(() {
      if(showAllVehicles) {
        for (Marker marker in _vehiclesMarkers) {
          markers[marker.markerId] = marker;
        }
      }
    });

    currentIndexFakeBusData += changeValueFakeBustData;
    if(currentIndexFakeBusData == _fakeNewBusPositions.length) {
      changeValueFakeBustData = -1;
      currentIndexFakeBusData = _fakeNewBusPositions.length - 2;
    } else if (currentIndexFakeBusData < 0) {
      changeValueFakeBustData = 1;
      currentIndexFakeBusData = 1;
    }
  }

  _updateAllMarkers() {
    markers.clear();
    if(showChosenRoute) {
      for (Marker marker in homeScreenMarkers) {
        markers[marker.markerId] = marker;
      }
    }
    if(showAllVehicles) {
      for (Marker marker in _vehiclesMarkers) {
        markers[marker.markerId] = marker;
      }
    }
  }
}
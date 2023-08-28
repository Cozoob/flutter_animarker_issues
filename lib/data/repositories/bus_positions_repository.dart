import 'dart:async';

import 'package:city_transit/domain/models/bus_marker.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusPositionsRepository  {
  // final busPositionsAPI busPositionsAPI;

  BusPositionsRepository();

  // FOR ISOLATE ONLY
  // Stream<BusMarker> fetchingBusData() async* {
  //   yield* Stream.periodic(
  //       const Duration(seconds: 5), (x) {
  //         print("no i cooooooo");
  //         return flutterCompute(isolateFetchBusMarker, "");
  //   }).asyncMap((event) async => await event);
  // }

  Stream<BusMarker> fetchingBusData() {
    return Stream.periodic(const Duration(seconds: 5), (x) => _updateBusLocations());
  }

  // TODO DELETE BELOW

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

  BusMarker _updateBusLocations() {

    Marker marker = Marker(
        markerId: const MarkerId('BUS_1'),
        position: LatLng(_fakeNewBusPositions[currentIndexFakeBusData].latitude, _fakeNewBusPositions[currentIndexFakeBusData].longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
    );

    currentIndexFakeBusData += changeValueFakeBustData;
    if(currentIndexFakeBusData == _fakeNewBusPositions.length) {
      changeValueFakeBustData = -1;
      currentIndexFakeBusData = _fakeNewBusPositions.length - 2;
    } else if (currentIndexFakeBusData < 0) {
      changeValueFakeBustData = 1;
      currentIndexFakeBusData = 1;
    }

    return BusMarker(markerId: marker.markerId, position: marker.position, marker: marker);
  }


}
// FOR ISOLATE ONLY
// const List<LatLng> _fakeNewBusPositions = [
//   LatLng(50.070224, 19.903174),
//   LatLng(50.071381, 19.895688),
//   LatLng(50.072458, 19.888634),
//   LatLng(50.074289, 19.888228),
//   LatLng(50.075753, 19.888757),
//   LatLng(50.078740, 19.889772),
//   LatLng(50.080673, 19.890447),
//   LatLng(50.083600, 19.891078),
//   LatLng(50.086618, 19.891536),
//   LatLng(50.088182, 19.892221),
//   LatLng(50.091733, 19.893449),
//   LatLng(50.094153, 19.893088),
//   LatLng(50.093657, 19.895415),
//   LatLng(50.093164, 19.897726),
//   LatLng(50.093515, 19.897516),
// ];
// var changeValueFakeBustData = 1;
// var currentIndexFakeBusData = 0;
//
// @pragma('vm:entry-point')
// Future<BusMarker> isolateFetchBusMarker(String arg) async {
//   print('isolate?');
//
//   Marker marker = Marker(
//       markerId: const MarkerId('BUS_1'),
//       position: LatLng(_fakeNewBusPositions[currentIndexFakeBusData].latitude, _fakeNewBusPositions[currentIndexFakeBusData].longitude),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
//   );
//
//   currentIndexFakeBusData += changeValueFakeBustData;
//   if(currentIndexFakeBusData == _fakeNewBusPositions.length) {
//     changeValueFakeBustData = -1;
//     currentIndexFakeBusData = _fakeNewBusPositions.length - 2;
//   } else if (currentIndexFakeBusData < 0) {
//     changeValueFakeBustData = 1;
//     currentIndexFakeBusData = 1;
//   }
//
//   return BusMarker(markerId: marker.markerId, position: marker.position, marker: marker);
// }
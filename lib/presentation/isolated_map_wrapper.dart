// import 'dart:async';
//
// import 'package:city_transit/domain/models/bus_marker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animarker/helpers/extensions.dart';
// import 'package:flutter_animarker/widgets/animarker.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'package:city_transit/presentation/bus_markers_isolate_bloc/bus_markers_isolate_bloc.dart';
// import 'package:isolate_bloc/isolate_bloc.dart';
//
// class IsolatedMapWrapper extends StatelessWidget {
//   static const LatLng _defaultLatLng = LatLng(50.061733, 19.935639);
//   static const double _defaultZoom = 12.0;
//   static const refreshMarkersDuration = Duration(seconds: 2);
//
//   final _completeMapController = Completer<GoogleMapController>();
//
//   IsolatedMapWrapper({super.key});
//
//   // HOW TO AVOID MAIN THREAD BEFORE DOING TOO MUCH
//   // https://stackoverflow.com/questions/14678593/the-application-may-be-doing-too-much-work-on-its-main-thread
//   @override
//   Widget build(BuildContext context) {
//     // Good to read: https://ppantaleon.medium.com/flutter-blocbuilder-vs-blocconsumer-vs-bloclistener-a4a3ce7bfa9a
//     return IsolateBlocConsumer<BusMarkersIsolateBloc, BusMarkersIsolateState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         return IsolateBlocBuilder<BusMarkersIsolateBloc, BusMarkersIsolateState>(
//             builder: (context, state) {
//               if (state is BusMarkersIsolateInitial) {
//                 // return const CircularProgressIndicator(color: Colors.orange);
//                 return const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(color: Colors.orange)
//                   ],
//                 );
//               }
//               if (state is BusMarkersLoaded) {
//                 final markers = <MarkerId, Marker>{};
//                 for (BusMarker busMarker in state.busMarkers) {
//                   // print('pentlaaa for');
//                   debugPrint('pentlaaa for');
//                   markers[busMarker.markerId] = busMarker.marker;
//                 }
//
//                 print('too much or what');
//                 print(state.busMarkers.toSet());
//
//
//                 return Animarker(
//                   shouldAnimateCamera: false,
//                   curve: Curves.bounceOut,
//                   rippleRadius: 0.2,
//                   useRotation: false,
//                   duration: const Duration(milliseconds: 2300),
//                   mapId: _completeMapController.future
//                       .then<int>((value) => value.mapId),
//                   markers: markers.values.toSet(),
//
//                   child: GoogleMap(
//                     initialCameraPosition: _defaultLocation,
//                     zoomControlsEnabled: false,
//                     onMapCreated: (controller) {
//                       // _mapController = controller;
//                       _completeMapController.complete(controller);
//                     },
//                     onTap: (coord) => print("Tapped on location: $coord"),
//                   ),
//                 );
//               } else {
//                 return const Text('Something went wrong!');
//               }
//             }
//         );
//       },
//     );
//   }
//
//   static const CameraPosition _defaultLocation = CameraPosition(
//       target: _defaultLatLng,
//       zoom: _defaultZoom
//   );
// }
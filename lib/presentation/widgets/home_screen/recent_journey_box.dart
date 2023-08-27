import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:city_transit/presentation/widgets/home_screen/recent_journey_dots.dart';
import 'package:city_transit/data/providers/home_provider.dart';
import 'package:city_transit/data/providers/map_mode_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

/// Represents a recent search box in the application.
class RecentJourneyBox extends StatefulWidget {
  final String departureName;
  final String destinationName;
  final LatLng departureLatLng;
  final LatLng destinationLatLng;
  GoogleMapController? mapController;
  final double iconSize = 30;
  final Color colorDeparture = const Color(0xFF3791FA);
  final Color colorDestination = const Color(0xFFDC5C00);

  /// Constructs a [RecentJourneyBox] widget.
  ///
  /// The [departureName] parameter is required and represents the starting stop name.
  /// The [destinationName] parameter is required and represents the final stop name.
  /// The [departureLatLng] parameter is required and represents location of the departure.
  /// The [destinationLatLng] parameter is required and represents location fot the destination.
  RecentJourneyBox({
    super.key,
    required this.departureName,
    required this.destinationName,
    required this.departureLatLng,
    required this.destinationLatLng
  });

  void _adjustCameraPosition() async {
    if (mapController != null) {
      final LatLng southwest = LatLng(
        min(departureLatLng.latitude, destinationLatLng.latitude),
        min(departureLatLng.longitude, destinationLatLng.longitude),
      );
      final LatLng northeast = LatLng(
        max(departureLatLng.latitude, destinationLatLng.latitude),
        max(departureLatLng.longitude, destinationLatLng.longitude),
      );
      final LatLng centerTarget = LatLng(
        (departureLatLng.latitude + destinationLatLng.latitude) / 2,
        (departureLatLng.longitude + destinationLatLng.longitude) / 2,
      );
      LatLngBounds bounds = LatLngBounds(
        southwest: southwest,
        northeast: northeast,
      );
      mapController!.moveCamera(CameraUpdate.newLatLngBounds(bounds, 10));
      double fixedZoom = await mapController!.getZoomLevel();
      mapController!.moveCamera(CameraUpdate.newLatLngZoom(centerTarget, fixedZoom));
    }
  }

  @override
  State<StatefulWidget> createState() => _RecentJourneyBoxState();
}

class _RecentJourneyBoxState extends State<RecentJourneyBox> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _performProvidersActions();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 83,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ]
          ),
          child: Row(
            children: [
              if (_markers.length == 2)
                Expanded(
                  flex: 3,
                  child: AbsorbPointer(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)
                      ),
                      child: GoogleMap(
                        onMapCreated: (controller) {
                          widget.mapController = controller;
                          widget._adjustCameraPosition();
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            (widget.departureLatLng.latitude + widget.destinationLatLng.latitude) / 2,
                            (widget.departureLatLng.longitude + widget.destinationLatLng.longitude) / 2,
                          ),
                          zoom: 10,
                        ),
                        markers: _markers,
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        compassEnabled: false,
                        mapToolbarEnabled: false,
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 1,
                child: RecentJourneyDots(
                  colorDeparture: widget.colorDeparture,
                  colorDestination: widget.colorDestination
                )
              ),
              Expanded(
                flex: 5,
                child: Container(
                    margin: const EdgeInsets.only(left: 13),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          AutoSizeText(
                            widget.departureName,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            minFontSize: 11,
                            maxFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          AutoSizeText(
                            widget.destinationName,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            minFontSize: 11,
                            maxFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12)
                        ]
                    )
                )
              )
            ]
          )
        )
      )
    );
  }

  void _addMarkers() async {
    BitmapDescriptor departureIcon =  await _createMarkerIcon(widget.colorDeparture);
    BitmapDescriptor destinationIcon =  await _createMarkerIcon(widget.colorDestination);
    setState(() {
      _markers.add(
          Marker(
              markerId: const MarkerId('departure'),
              position: widget.departureLatLng,
              icon: departureIcon,
              anchor: const Offset(0.5, 0.5)
          )
      );
      _markers.add(
          Marker(
              markerId: const MarkerId('destination'),
              position: widget.destinationLatLng,
              icon: destinationIcon,
              anchor: const Offset(0.5, 0.5)
          )
      );
    });
  }

  Future<BitmapDescriptor> _createMarkerIcon(Color color) async {
    final Uint8List markerIcon = await getBytesFromCanvas(widget.iconSize, color);
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> getBytesFromCanvas(double size, Color color) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // Draw the circle
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);

    final img = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  void _performProvidersActions() async {
    await Provider.of<HomeScreenProvider>(context, listen: false).buildRouteHomeScreen(widget.departureLatLng, widget.destinationLatLng);
    Provider.of<MapModeProvider>(context, listen: false).changeMode('RECENT_JOURNEY_BOX');
  }
}

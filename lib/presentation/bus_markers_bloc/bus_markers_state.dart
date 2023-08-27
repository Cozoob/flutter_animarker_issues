part of 'bus_markers_bloc.dart';

@immutable
abstract class BusMarkersState extends Equatable {
  const BusMarkersState();

  @override
  List<Object?> get props => [];
}

class BusMarkersInitial extends BusMarkersState {}

class BusMarkersLoaded extends BusMarkersState {
  final List<BusMarker> busMarkers;
  final List<Marker> markers;
  final Completer<GoogleMapController> completeMapController;

  const BusMarkersLoaded({required this.busMarkers, required this.markers, required this.completeMapController});

  @override
  List<Object?> get props => [markers];
}

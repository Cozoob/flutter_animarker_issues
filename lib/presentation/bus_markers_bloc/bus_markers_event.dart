part of 'bus_markers_bloc.dart';

@immutable
abstract class BusMarkersEvent extends Equatable {
  const BusMarkersEvent();

  @override
  List<Object?> get props => [];
}

class LoadBusMarkers extends BusMarkersEvent {}

class AddBusMarker extends BusMarkersEvent {
  final BusMarker busMarker;

  const AddBusMarker(this.busMarker);

  @override
  List<Object?> get props => [busMarker];
}

class RemoveBusMarker extends BusMarkersEvent {
  final BusMarker busMarker;

  const RemoveBusMarker(this.busMarker);

  @override
  List<Object?> get props => [busMarker];
}

class ChangeBusMarker extends BusMarkersEvent {
  final BusMarker busMarker;

  const ChangeBusMarker(this.busMarker);

  @override
  List<Object?> get props => [busMarker];
}

class PassMapController extends BusMarkersEvent {
  final GoogleMapController completeMapController;

  const PassMapController(this.completeMapController);

  @override
  List<Object?> get props => [completeMapController];
}
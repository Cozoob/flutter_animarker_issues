import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:city_transit/domain/models/bus_marker.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

import 'package:city_transit/data/repositories/bus_positions_repository.dart';

part 'bus_markers_event.dart';
part 'bus_markers_state.dart';

class BusMarkersBloc extends Bloc<BusMarkersEvent, BusMarkersState> {
  // final BusPositionsRepository _busPositionsRepository = BusPositionsRepository();

  /// to listen to the bus positions stream
  StreamSubscription<BusMarker>? _busPositionsSubscription;


  // better way to make handlers to this events like here https://medium.com/@minh.ho89/bloc-simple-explain-and-walkthrough-building-a-countdown-timer-using-flutter-bloc-part-1-e128e3ea26ac
  BusMarkersBloc() : super(BusMarkersInitial()) {
    on<LoadBusMarkers>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 10)); // is it needed?

      // In case of there is an subscription exists, we have to cancel it
      _busPositionsSubscription?.cancel();
      /// makes the subscription listen to TimerTicked state
      _busPositionsSubscription = BusPositionsRepository()
          .fetchingBusData()
          .listen((busMarker) => add(ChangeBusMarker(busMarker)));
      // FlutterIsolate.spawn(isolateStreamBusData, "");

      emit(
          BusMarkersLoaded(
            busMarkers: const <BusMarker>[],
            markers: const <Marker>[],
            completeMapController: Completer<GoogleMapController>()
          )
      );
    });
    on<AddBusMarker>((event, emit) {
      // if (state is BusMarkersLoaded) {
      //   final state = this.state as BusMarkersLoaded;
      //   // emit(
      //   //   BusMarkersLoaded(
      //   //       busMarkers: List.from(state.busMarkers)..add(event.busMarker),
      //   //       markers: const <Marker>[]
      //   //   )
      //   );
      // }
    });
    on<RemoveBusMarker>((event, emit) {
      // if (state is BusMarkersLoaded) {
      //   final state = this.state as BusMarkersLoaded;
      //   // emit(
      //   //   BusMarkersLoaded(
      //   //       busMarkers: List.from(state.busMarkers)..remove(event.busMarker),
      //   //     markers: const <Marker>[],
      //   //
      //   //   )
      //   );
      // }
    });
    on<ChangeBusMarker>((event, emit) {
      print(state);


      if (state is BusMarkersLoaded) {
        print('ChangeBusMarker');
        final state = this.state as BusMarkersLoaded;

        // make it into map of elements, find busmarkerid if exists delete
        // and add newest marker of markerid...
        emit(
            BusMarkersLoaded(
                busMarkers: <BusMarker>[event.busMarker],
                markers: <Marker>[event.busMarker.marker],
                completeMapController: state.completeMapController
            )
        );
      }


      // if (state is BusMarkersLoaded) {
      //   print('XDDDDDDDDD');
      //   print('ChangeBusMarker');
      //   final state = this.state as BusMarkersLoaded;
      //
      //  // make it into map of elements, find busmarkerid if exists delete
      //   // and add newest marker of markerid...
      //   emit(
      //     BusMarkersLoaded(
      //         busMarkers: <BusMarker>[event.busMarker],
      //         markers: <Marker>[event.busMarker.marker],
      //         completeMapController: state.completeMapController
      //     )
      //   );
      // }
    });
    on<PassMapController>((event, emit) {
      if (state is BusMarkersLoaded) {
        final state = this.state as BusMarkersLoaded;

        state.completeMapController.complete(event.completeMapController);

        print('complete?');
        // emit(
        //   BusMarkersLoaded(
        //       busMarkers: const <BusMarker>[],
        //       markers: const <Marker>[]
        //   )
        // );
      }
    });
    // on<BusMarkersEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  @override
  Future<void> close() {
    _busPositionsSubscription?.cancel();
    return super.close();
  }

  // https://stackoverflow.com/questions/61891062/flutter-bloc-using-timer-to-refetch-data
  // @override
  // Stream<BusMarkersBloc>
}

// /// to listen to the bus positions stream
// StreamSubscription<BusMarker>? _busPositionsSubscription;
//
// @pragma('vm:entry-point')
// void isolateStreamBusData(String arg) async {
//   print('isolate?');
//
//   //In case of there is an subscription exists, we have to cancel it
//   _busPositionsSubscription?.cancel();
//   /// makes the subscription listen to TimerTicked state
//   _busPositionsSubscription = BusPositionsRepository()
//       .fetchingBusData()
//       .listen((busMarker) => BusMarkersBloc().add(ChangeBusMarker(busMarker)));
// }

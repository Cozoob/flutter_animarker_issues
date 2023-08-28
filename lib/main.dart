import 'package:city_transit/data/providers/home_provider.dart';
import 'package:city_transit/data/providers/map_mode_provider.dart';
import 'package:city_transit/presentation/bus_markers_bloc/bus_markers_bloc.dart';
import 'package:city_transit/presentation/map_wrapper.dart';

import 'package:city_transit/presentation/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // await initialize(isolateInitialization);
  runApp(const CityTransitApp());
}

/// Represents the root of the app.
class CityTransitApp extends StatelessWidget {
  const CityTransitApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent
        )
    );

    // NO BLOCS
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<MapModeProvider>(
    //       create: (_) => MapModeProvider(),
    //     ),
    //     ChangeNotifierProvider<HomeScreenProvider>(
    //         create: (_) => HomeScreenProvider(),
    //     ),
    //     Provider<MapWrapper>(
    //         create: (_) => const MapWrapper(),
    //     )
    //   ],
    //   child: MaterialApp(
    //       // You can set here language code and country code.
    //       // More info https://www.youtube.com/watch?v=Y6rFwIoiAR4&ab_channel=amplifyabhicoding
    //       // For the future work.
    //       locale: const Locale('en', 'PL'),
    //       debugShowCheckedModeBanner: false,
    //       title: 'City Transit',
    //       theme: ThemeData(
    //         scaffoldBackgroundColor: Colors.white
    //       ),
    //       home: const Wrapper()
    //       // home: SimpleMarkerAnimationExample()
    //     )
    // );


    // FOR BLOCS
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => BusMarkersBloc()..add(LoadBusMarkers())
          )
        ],
        child: MaterialApp(
          // You can set here language code and country code.
          // More info https://www.youtube.com/watch?v=Y6rFwIoiAR4&ab_channel=amplifyabhicoding
          // For the future work.
            locale: const Locale('en', 'PL'),
            debugShowCheckedModeBanner: false,
            title: 'City Transit',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white
            ),
            home: const Wrapper()
          // home: SimpleMarkerAnimationExample()
        )
    );
  }
}

// BETTER TO DO THIS IN DIFFERENT FILE\
// https://github.com/Maksimka101/isolate-bloc/blob/master/examples/weather_app/lib/isolate_initialization.dart

// void isolateInitialization() {
//   register<BusMarkersIsolateBloc, BusMarkersIsolateState>(
//       create: () => BusMarkersIsolateBloc()..add(LoadBusMarkers())
//   );
//
// }
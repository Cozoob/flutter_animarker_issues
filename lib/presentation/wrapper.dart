import 'package:city_transit/presentation/bus_markers_bloc/bus_markers_bloc.dart';
import 'package:city_transit/presentation/map_wrapper.dart';
import 'package:city_transit/presentation/newest_map_wrapper.dart';
import 'package:city_transit/presentation/screens/home_screen.dart';
import 'package:city_transit/presentation/screens/planning_screen.dart';
import 'package:city_transit/presentation/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:city_transit/presentation/isolated_map_wrapper.dart';

import 'package:city_transit/single_marker_animation_example.dart'; // ACTUAL EXAMPLE
// import 'package:city_transit/presentation/map_wrapper_the_second.dart'; // EDITED EXAMPLE

/// Represents the wrapper for the main screen in app.
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final PanelController panelController = PanelController();

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // FORMER LAGGING WRAPPER
            // const MapWrapper(),

            // EXAMPLE NOT LAGGING
            //SimpleMarkerAnimationExample(),

            // NEWEST MAP WRAPPER
            const NewestMapWrapper(),

            // ISOLATED NEWEST MAP WRAPPER
            // IsolatedMapWrapper(),
            // NOT WORKING :) -> isolate binding errors

            SlidingUpPanel(
              controller: panelController,
              minHeight: 150,
              maxHeight: SizeConfig.screenHeight! * 0.92,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)
              ),
              snapPoint: 0.5,
              panel: Container(
                height: MediaQuery.of(context).size.height * 0.92,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Navigator(
                    initialRoute: 'sheet/home_screen',
                    onGenerateRoute: (RouteSettings settings) {
                      WidgetBuilder builder;
                      switch (settings.name) {
                        case 'sheet/home_screen':
                          builder = (BuildContext context) => HomeScreen(panelController: panelController);
                        case 'sheet/searching_screen':
                          builder = (BuildContext context) => PlanningScreen();
                        default:
                          throw Exception('Invalid route: ${settings.name}');
                      }
                      return MaterialPageRoute<void>(builder: builder, settings: settings);
                    }
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}
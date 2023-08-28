//import 'package:city_transit/presentation/screens/routes_screen.dart';
import 'package:city_transit/presentation/utils/size_config.dart';
import 'package:city_transit/presentation/widgets/common/custom_back_button.dart';
import 'package:city_transit/presentation/widgets/common/custom_journey_search_bar.dart';
import 'package:city_transit/presentation/widgets/home_screen/recent_journey_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Represents the journey planning screen of the app.
class PlanningScreen extends StatelessWidget {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  List<List<String>> recentRoutes = [
    ["Miasteczko Studenckie AGH", "Rondo Matecznego"],
    ["AGH / UR", "Wieliczka Kopalnia Soli"],
    ["Bonarka City Center", "Prokocim Szpital"],
    ["Kawiory", "Plac Inwalidów"],
    ["Plac Inwalidów", "Bociana"],
    ["Szpital Narutowicza", "Poczta Główna"],
    ["Starowiślna", "Jubilat"]
  ];

  /// Constructs a [PlanningScreen] widget.
  PlanningScreen({super.key});

  /// Callback function for search submission.
  ///
  /// Prints the submitted search value.
  void _onSearchSubmitted(String value) {
    print('Search: $value');
  }

  @override
  Widget build(BuildContext context) {
    _fromController.text = "Current location";
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: const CustomBackButton(),
                    onTap: () {
                      // Navigator.of(context).push(_moveToHomeScreen());
                    }
                  )
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("Journey planning")
                )
              ]
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 25
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          CustomJourneySearchBar(
                              type: "From",
                              hint: "",
                              autofocus: false,
                              controller: _fromController,
                              onSubmitted: _onSearchSubmitted
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 10
                              ),
                              child: CustomJourneySearchBar(
                                  type: "To",
                                  hint: "",
                                  autofocus: true,
                                  controller: _toController,
                                  onSubmitted: (String value) {
                                    //Navigator.of(context).push(_moveToRoutesScreen());
                                  }
                              )
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20
                            ),
                            height: 30,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      debugPrint('Now clicked');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00C908),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Now', style: TextStyle(
                                      color: Colors.white,
                                    )),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      debugPrint('Options clicked');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        backgroundColor: Colors.transparent,
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.black
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        elevation: 0
                                    ),
                                    child: const Text('Options', style: TextStyle(
                                      color: Colors.black,
                                    )),
                                  ),
                                ]
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 30
                              ),
                              alignment: Alignment.topLeft,
                              child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Recent routes"),
                                  ]
                              )
                          )
                        ]
                      )
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: false,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 25),
                        itemCount: recentRoutes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RecentJourneyBox(
                              departureName: recentRoutes[index][0],
                              destinationName: recentRoutes[index][1],
                              destinationLatLng: const LatLng(49.983414, 20.053646),
                              departureLatLng: const LatLng(49.983414, 20.053646)
                          );
                        }
                      )
                    )
                  ]
                )
              )
            )
          ],
        )
      )
    );
  }
}

// Route _moveToHomeScreen() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }

// Route _moveToRoutesScreen() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => RoutesScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }
import 'dart:convert';

import 'package:city_transit/presentation/utils/size_config.dart';
import 'package:city_transit/presentation/widgets/home_screen/place_shortcut.dart';
import 'package:city_transit/presentation/widgets/home_screen/place_suggestions_list.dart';
import 'package:city_transit/presentation/widgets/home_screen/search_history_list.dart';
import 'package:flutter/material.dart';
import 'package:city_transit/presentation/widgets/circular_search_bar.dart';
import 'package:city_transit/presentation/utils/app_style.dart';
import 'package:city_transit/presentation/widgets/home_screen/recent_journeys_list.dart';
import 'package:city_transit/data/providers/map_mode_provider.dart';
import 'package:provider/provider.dart';
import 'package:city_transit/presentation/widgets/common/horizontal_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;

import '../../domain/models/place.dart';

/// Represents the home screen of the app.
class HomeScreen extends StatefulWidget {
  final PanelController panelController;

  const HomeScreen({Key? key, required this.panelController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool hasTyped = false;

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  List<Place> placeSuggestions = [];

  List<PlaceShortcut> placeShortcuts = [
    const PlaceShortcut(
        icon: Icons.home,
        iconColor: Colors.black,
        text: 'Home',
        textStyle: AppStyle.smallTextStyle
    ),
    const PlaceShortcut(
        icon: Icons.cases_rounded,
        iconColor: Colors.black,
        text: 'Work',
        textStyle: AppStyle.smallTextStyle
    )
  ];

  /// Callback function when search bar is focused.
  ///
  /// Opens the sliding up panel via the panel controller.
  void _onFocusChanged(bool isFocused) {
    if (isFocused) {
      widget.panelController.open();
      hasTyped = true;
    } else if (_searchController.text.isEmpty) {
      hasTyped = false;
    }
  }

  /// Callback function for search change.
  ///
  /// Fetches the suggestions.
  void _onChanged(String value) async {
    await fetchSearchSuggestions(value);
  }

  Future<void> fetchSearchSuggestions(String query) async {
    query = query.replaceAll(' ', '-');

    final response = await http
        .get(Uri.parse("https://photon.komoot.io/api/?q=$query&lat=50.0524&lon=19.9354&lang=en"));

    if (response.statusCode == 200) {
      final fetchedSuggestions = jsonDecode(response.body);
      List<Place> suggestionsList = [];

      for (var feature in fetchedSuggestions["features"]) {
        String value = feature["properties"]["osm_value"];
        if (["gift", "apartment"].contains(value)) {
          continue;
        }

        String placeName = feature["properties"]["name"];
        String address = "";

        if (feature["properties"]["street"] != null && feature["properties"]["housenumber"] != null) {
          address = feature["properties"]["street"] + " " + feature["properties"]["housenumber"];

          if (feature["properties"]["postcode"] != null && feature["properties"]["city"] != null) {
            address += ", " + feature["properties"]["postcode"] + " " + feature["properties"]["city"];
          }
        }

        Place newSuggestion = Place(
          name: placeName,
          address: address
        );

        suggestionsList.add(newSuggestion);
      }

      setState(() {
        placeSuggestions = suggestionsList;
      });
    } else {
      throw Exception("Failed to fetch search suggestions!");
    }
  }

  /// HOW TO DO THIS DIFFERENTLY?
  void _showAddPlaceModal() {
    int selectedIconIndex = 0; // To store the index of the selected icon

    showDialog(
      context: context,
      builder: (context) {
        String address = '';
        String name = '';

        List<IconData> availableIcons = [
          Icons.place,
          Icons.school,
          Icons.restaurant,
          Icons.shopping_cart,
          Icons.local_hospital,
        ];

        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('Add New Place'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Address'),
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    const Text('Select an icon:'),
                    Column(
                      children: List.generate(availableIcons.length, (index) {
                        return RadioListTile(
                          title: Icon(availableIcons[index]),
                          value: index,
                          groupValue: selectedIconIndex,
                          onChanged: (value) {
                            print('wtf');
                            print(value);
                            setState(() {
                              selectedIconIndex = value as int;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add the new PlaceIcon to the placeShortcuts list
                      setState(() {
                        placeShortcuts.insert(
                          placeShortcuts.length - 1,
                          PlaceShortcut(
                            icon: availableIcons[selectedIconIndex], // You can customize the icon here
                            iconColor: Colors.white,
                            text: name,
                            textStyle: AppStyle.smallTextStyle,
                          ),
                        );
                      });

                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            }
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    placeShortcuts.addAll([
      PlaceShortcut(
        icon: Icons.add_location,
        iconColor: Colors.black,
        text: 'Add place',
        textStyle: AppStyle.smallTextStyle,
        onTap: () {
          _showAddPlaceModal();
        }
      ),
      PlaceShortcut(
        icon: Icons.clear,
        iconColor: Colors.white,
        text: 'CLEAR MAP',
        textStyle: AppStyle.smallTextStyle,
        onTap: () => {
          Provider.of<MapModeProvider>(context, listen: false).changeMode('HOME')
        }
      )
    ]);

    hasTyped = true;
    widget.panelController.open();

    placeSuggestions = [
      Place(
        name: "Galeria Kazimierz",
        address: "Podgórska 34, 31-536 Kraków"
      ),
      Place(
        name: "Galeria Lue Lue"
      ),
      Place(
        name: "Galeria Bronowice",
        address: "Stawowa 61, 31-346 Kraków"
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Spacer(),
            Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey
              ),
            ),
            const Spacer()
          ]
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: CircularSearchBar(
            controller: _searchController,
            onFocusChanged: _onFocusChanged,
            onChanged: _onChanged,
            onSubmitted: (String _) {}
          )
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: HorizontalList(
            width: SizeConfig.screenWidth!,
            height: 35,
            spaceBetween: 10,
            list: placeShortcuts
          )
        ),
        Expanded(
          child: hasTyped ? (placeSuggestions.isNotEmpty ? PlaceSuggestionsList(placeSuggestions: placeSuggestions) : const SearchHistoryList()) : const RecentJourneysList()
        )
      ]
    );
  }
}
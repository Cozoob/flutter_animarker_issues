import 'package:auto_size_text/auto_size_text.dart';
import 'package:city_transit/presentation/widgets/home_screen/search_history_box.dart';
import 'package:flutter/material.dart';
import 'package:city_transit/domain/models/place.dart';
import 'package:city_transit/presentation/utils/size_config.dart';

/// Represents a list of search history for the current user.
class SearchHistoryList extends StatefulWidget {
  const SearchHistoryList({Key? key}) : super(key: key);

  @override
  _SearchHistoryListState createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  List<Place> searchHistory = [
    Place(
      name: "Centrum Informatyki, AGH, D-17",
      address: "Kawiory 21, 30-055 Kraków"
    ),
    Place(
      name: "Osiedle Mozarta",
      address: "Kraków"
    ),
    Place(
      name: "Galeria Krakowska"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const AutoSizeText(
            "Search history",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
            maxLines: 1,
            minFontSize: 14,
            maxFontSize: 18,
            overflow: TextOverflow.ellipsis
          )
        ),
        Container(
          width: SizeConfig.screenWidth,
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5
              )
            )
          )
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: false,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemCount: searchHistory.length,
            itemBuilder: (BuildContext context, int index) {
              Place placeItem = searchHistory[index];

              return SearchHistoryBox(
                text: placeItem.name,
                subText: placeItem.address
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          )
        )
      ]
    );
  }
}
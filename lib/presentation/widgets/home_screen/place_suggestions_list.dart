import 'package:auto_size_text/auto_size_text.dart';
import 'package:city_transit/presentation/widgets/home_screen/place_suggestion_box.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/place.dart';
import '../../utils/size_config.dart';

/// Represents a list of place suggestions for the current user.
class PlaceSuggestionsList extends StatefulWidget {
  final List<Place> placeSuggestions;

  const PlaceSuggestionsList({Key? key, required this.placeSuggestions}) : super(key: key);

  @override
  _PlaceSuggestionsListState createState() => _PlaceSuggestionsListState();
}

class _PlaceSuggestionsListState extends State<PlaceSuggestionsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const AutoSizeText(
            "Search suggestions",
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
            itemCount: widget.placeSuggestions.length,
            itemBuilder: (BuildContext context, int index) {
              Place placeItem = widget.placeSuggestions[index];

              return PlaceSuggestionBox(
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
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:city_transit/presentation/widgets/home_screen/recent_journey_box.dart';
import 'package:city_transit/domain/models/recent_journey.dart';
import 'package:city_transit/data/datasources/recent_journeys_source.dart';
import 'package:city_transit/presentation/utils/size_config.dart';

/// Represents a list of recent journeys for the current user.
class RecentJourneysList extends StatefulWidget {
  const RecentJourneysList({Key? key}) : super(key: key);

  @override
  _RecentJourneysListState createState() => _RecentJourneysListState();
}

class _RecentJourneysListState extends State<RecentJourneysList> {
  // final List<RecentJourney> recentRoutes = [
  //   RecentJourney(
  //       departureName: "Miasteczko Studenckie AGH",
  //       destinationName: "Rondo Matecznego",
  //       departureCoords: const LatLng(50.068734, 19.905864),
  //       destinationCoords: const LatLng(50.048336, 19.933289)
  //   ),
  //   RecentJourney(
  //       departureName: "AGH / UR",
  //       destinationName: "Wieliczka Kopalnia Soli",
  //       departureCoords: const LatLng(50.062602, 19.923186),
  //       destinationCoords: const LatLng(49.983414, 20.053646)
  //   ),
  // ];

  List<RecentJourney> recentRoutes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const AutoSizeText(
            "Recent journeys",
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
          child: ListView.builder(
            shrinkWrap: false,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemCount: recentRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              RecentJourney recentJourney = recentRoutes[index];

              return RecentJourneyBox(
                departureName: recentJourney.departureName,
                destinationName: recentJourney.destinationName,
                departureLatLng: recentJourney.departureCoords,
                destinationLatLng: recentJourney.destinationCoords
              );
            }
          )
        )
      ]
    );
  }

  Future<void> _getLocations() async {
    List<RecentJourney>  locations = await RecentJourneysSource.getLocations();

    if (locations.isNotEmpty) {
      setState(() {
        for (var location in locations) {
          recentRoutes.add(location);
        }
      });
    }
  }
}
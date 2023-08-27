import 'package:flutter/material.dart';
import 'package:city_transit/presentation/widgets/home_screen/recent_journey_box.dart';
import 'package:city_transit/domain/models/recent_journey.dart';

import 'package:city_transit/data/datasources/recent_journeys_source.dart';

/// Represents a list of recent journeys for the current user.
class RecentJourneysList extends StatefulWidget {
  const RecentJourneysList({Key? key}) : super(key: key);
  @override
  _RecentJourneysListState createState() => _RecentJourneysListState();
}


class _RecentJourneysListState extends State<RecentJourneysList> {
  late List<RecentJourney> recentRoutes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: false,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 25),
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
    );
  }

  Future<void> _getLocations() async {
    List<RecentJourney>  locations = await RecentJourneysSource.getLocations();
    if(locations.isNotEmpty) {
      setState(() {
        for (var location in locations) {
          recentRoutes.add(location);
        }
      });
    }
  }
}
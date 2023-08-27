import 'package:flutter/material.dart';

class RecentJourneyDots extends StatelessWidget {
  final Color colorDeparture;
  final Color colorDestination;

  const RecentJourneyDots({super.key, required this.colorDeparture, required this.colorDestination});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorDeparture,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 16
                  )
              ),
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFDFDF),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFDFDF),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFDFDF),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: colorDestination,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                      size: 16
                  )
              )
            ]
        )
    );
  }
}
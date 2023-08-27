import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Represents a suggested route box in the application.
class SuggestedRouteBoxDelays extends StatefulWidget {
  final String fromStop;
  final String toStop;
  final String fromDate;
  final String toDate;
  final int departureTime;
  final int travelTime;

  /// Constructs a [SuggestedRouteBoxDelays] widget.
  ///
  /// The [fromStop] parameter is required and represents the initial stop on the journey
  /// The [toStop] parameter is required and represents the destination stop on the journey
  /// The [fromDate] parameter is required and represents the departure time from the initial stop
  /// The [toDate] parameter is required and represents the arrival time on the destination stop
  /// The [departureTime] parameter is required and represents the departure time left in minutes
  /// The [travelTime] parameter is required and represents the travel time in minutes
  const SuggestedRouteBoxDelays(
      {super.key, required this.fromStop, required this.toStop,
      required this.fromDate, required this.toDate, required this.departureTime,
      required this.travelTime});

  @override
  State<StatefulWidget> createState() => _SuggestedRouteBoxDelaysState();
}

class _SuggestedRouteBoxDelaysState extends State<SuggestedRouteBoxDelays> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 25,
                  margin: const EdgeInsets.fromLTRB(15, 10, 13, 0),
                  padding: const EdgeInsets.fromLTRB(35, 0, 20, 5),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF2147),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)
                    )
                  ),
                  child: const Text("Possible delays on the route",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13
                    )
                  )
                )
              )
            ]
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: const EdgeInsets.only(top: 30),
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ]
              ),
              child: Column(
                children: [
                  Container(
                    height: 102,
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 16,
                                height: 16,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3791FA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.white,
                                    size: 16
                                )
                            ),
                            Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFDFDF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFDFDF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDFDFDF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Container(
                                width: 16,
                                height: 16,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDC5C00),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 16
                                )
                            )
                          ]
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 0),
                                child: Text(widget.fromStop, style: const TextStyle(
                                    color: Color(0xFF2F3542),
                                    fontSize: 13.0
                                ))
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 0),
                                child: Text(widget.fromDate, style: TextStyle(
                                  color: const Color(0xFF2F3542).withOpacity(0.5),
                                  fontSize: 12.0
                                ))
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(widget.toStop, style: const TextStyle(
                                    color: Color(0xFF2F3542),
                                    fontSize: 13.0
                                ))
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 0),
                                child: Text(widget.toDate, style: TextStyle(
                                    color: const Color(0xFF2F3542).withOpacity(0.5),
                                    fontSize: 12.0
                                ))
                              ),
                            ]
                          )
                        ),
                        Container(
                          height: 102,
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 0.5, color: Color(0x7D000000))
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Departure in:", style: TextStyle(
                                color: const Color(0xFF000000).withOpacity(0.5),
                                fontSize: 13
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(widget.departureTime.toString().padLeft(2, "0"),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40
                                  )),
                                  const Text("min")
                                ]
                              ),
                              Text("Travel time: ${widget.travelTime} min", style: TextStyle(
                                  color: const Color(0xFF000000).withOpacity(0.5),
                                  fontSize: 13
                              ))
                            ],
                          )
                        )
                      ]
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Container(
                        height: 58,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 0.5, color: Color(0x7D000000))
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Start", style: TextStyle(
                                  color: const Color(0xFF000000).withOpacity(0.5),
                                  fontSize: 13
                                )),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.directions_walk_rounded,
                                      color: Colors.black,
                                      size: 30
                                    ),
                                    Text("500m", style: TextStyle(
                                      fontSize: 12
                                    ))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Color(0x7D000000),
                                size: 13
                              )
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("14:50", style: TextStyle(
                                    color: const Color(0xFF000000).withOpacity(0.5),
                                    fontSize: 13
                                )),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.directions_bus_outlined,
                                        color: Colors.black,
                                        size: 30
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: const Color(0xFFFA8937)
                                        ),
                                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                        child: const Text("173", style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white
                                        ))
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0x7D000000),
                                    size: 13
                                )
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("14:58", style: TextStyle(
                                    color: const Color(0xFF000000).withOpacity(0.5),
                                    fontSize: 13
                                )),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                        Icons.directions_walk_rounded,
                                        color: Colors.black,
                                        size: 30
                                    ),
                                    Text("200m", style: TextStyle(
                                        fontSize: 12
                                    ))
                                  ],
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0x7D000000),
                                    size: 13
                                )
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("14:50", style: TextStyle(
                                    color: const Color(0xFF000000).withOpacity(0.5),
                                    fontSize: 13
                                )),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.tram_outlined,
                                      color: Colors.black,
                                      size: 30,
                                      weight: 100,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFFDF37FA)
                                      ),
                                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                      child: const Text("50", style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white
                                      ))
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0x7D000000),
                                    size: 13
                                )
                            )
                          ],
                        )
                      ))
                    ],
                  )
                ],
              )
            )
          ),
          Container(
              width: 34,
              height: 34,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFF2147),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                CupertinoIcons.exclamationmark,
                size: 24,
                color: Colors.white
              )
          ),
        ]
      )
    );
  }
}

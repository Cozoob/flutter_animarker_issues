import 'package:flutter/material.dart';
import 'package:city_transit/domain/models/stop.dart';
import 'package:intl/intl.dart';

// TODO comments and tests
class CustomExpansionTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String trailingText;
  final Color color;
  final List<Stop> stops;
  final List<TimeOfDay> arrivalTimes;

  const CustomExpansionTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.trailingText,
      required this.stops,
      required this.arrivalTimes,
      required this.color})
      : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // TODO combine stops and times into one obj
    final firstStop = widget.stops[0];
    final firstTime = widget.arrivalTimes[0];

    final lastStop = widget.stops[widget.stops.length - 1];
    final lastTime = widget.arrivalTimes[widget.arrivalTimes.length - 1];

    final inBetweenStops = widget.stops.sublist(1, widget.stops.length - 1);
    final inBetweenTimes =
        widget.arrivalTimes.sublist(1, widget.arrivalTimes.length - 1);

    final stopCount = inBetweenStops.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
            minLeadingWidth: 8,
            leading: Icon(widget.icon),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: Text(
              '${widget.trailingText} min',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    minLeadingWidth: 8,
                    leading: Container(
                        width: 16,
                        height: 16,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.arrow_drop_down,
                            color: Colors.white, size: 16)),
                    title: Text(firstStop.name),
                    trailing: Text(
                      // '${firstTime.hour}:${firstTime.minute}',
                      DateFormat.Hm().format(DateTime(0, 0, 0, firstTime.hour, firstTime.minute)),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  if (_isExpanded)
                    // for (final item in inBetweenStops)
                    for (int i = 0; i < inBetweenTimes.length; i++)
                      ListTile(
                        minLeadingWidth: 8,
                        leading: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        title: Text(inBetweenStops[i].name),
                        trailing: Text(
                          DateFormat.Hm().format(DateTime(0, 0, 0, inBetweenTimes[i].hour, inBetweenTimes[i].minute)),
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                  if (stopCount > 2 && !_isExpanded)
                    ListTile(
                      minLeadingWidth: 8,
                      leading: Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      title: Text(
                        '+ ${stopCount - 2} more stops',
                        style: TextStyle(fontSize: 14, color: widget.color.withOpacity(0.6)),
                      ),
                    ),
                  ListTile(
                    minLeadingWidth: 8,
                    leading: Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.arrow_drop_down,
                            color: Colors.white, size: 16)),
                    title: Text(lastStop.name),
                    trailing: Text(
                      DateFormat.Hm().format(DateTime(0, 0, 0, lastTime.hour, lastTime.minute)),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

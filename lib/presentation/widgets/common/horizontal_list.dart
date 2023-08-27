import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  /// The width of the container for the horizontal list.
  final double width;
  /// The height of the container for the horizontal list.
  final double height;
  /// The space between items inside the horizontal list.
  final double spaceBetween;
  /// The list of widgets to put inside the horizontal list.
  final List<Widget> list;

  const HorizontalList({
    Key? key,
    required this.width,
    required this.height,
    required this.spaceBetween,
    required this.list,
  }) : super(key: key);

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return widget.list[index];
          },
          separatorBuilder: (context, index) {
            return SizedBox(
                width: widget.spaceBetween
            );
          }
        )
    );
  }
}
import 'package:flutter/material.dart';

/// Represents a custom search bar in the application.
class CustomJourneySearchBar extends StatefulWidget {
  final String type;
  final String hint;
  final bool autofocus;
  final TextEditingController controller;
  final void Function(String) onSubmitted;

  /// Constructs a [CustomJourneySearchBar] widget.
  ///
  /// The [type] parameter is required and represents the orange text on the left.
  /// The [hint] parameter is required and represents the text used as a hint.
  /// The [autofocus] parameter is required and represents the autofocus functionality.
  /// The [controller] parameter is required and represents the text editing controller for the search bar.
  /// The [onSubmitted] parameter is required and represents the callback function for search submission.
  const CustomJourneySearchBar(
      {super.key, required this.type, required this.hint, required this.autofocus,
        required this.controller, required this.onSubmitted});

  @override
  State<StatefulWidget> createState() => _CustomJourneySearchBarState();
}

class _CustomJourneySearchBarState extends State<CustomJourneySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              )
            ]
          ),
          child: TextField(
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            autofocus: widget.autofocus,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              prefixIcon: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 70),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 12,
                    right: 0),
                  child: Text(widget.type, style: const TextStyle(
                    color: Color(0xFFDC5C00),
                    fontWeight: FontWeight.bold
                  ))
                )
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              hintText: widget.hint
            ),
          )
        )
      ],
    );
  }
}

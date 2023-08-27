import 'package:flutter/material.dart';

/// Represents a place suggestion box in the application
class PlaceSuggestionBox extends StatefulWidget {
  final String text;
  final String subText;

  /// Constructs a [PlaceSuggestionBox] widget
  ///
  /// The [text] parameter is required and represents the main text of the suggestion.
  /// The [subText] parameter is optional and represents the sub text of the suggestion.
  const PlaceSuggestionBox({
    super.key,
    required this.text,
    this.subText = ""
  });

  @override
  State<StatefulWidget> createState() => _PlaceSuggestionBoxState();
}

class _PlaceSuggestionBoxState extends State<PlaceSuggestionBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 60,
          height: 50,
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle
            ),
            child: const Icon(
              Icons.location_on,
              color: Colors.black,
              size: 20
            )
          )
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: const TextStyle(fontSize: 15)
                        ),
                        if (widget.subText.isNotEmpty)
                          Text(
                            widget.subText,
                            style: const TextStyle(color: Colors.grey)
                          )
                      ]
                    )
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 40,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.grey[500],
                      size: 24,
                    )
                  )
                ]
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200]!,
                      width: 0.5
                    )
                  )
                )
              )
            ]
          )
        )
      ]
    );
  }
}
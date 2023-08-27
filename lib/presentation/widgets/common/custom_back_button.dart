import 'package:flutter/material.dart';

/// Represents a custom back button in the application
class CustomBackButton extends StatefulWidget {
  /// Constructs a [CustomBackButton] widget
  ///
  /// The [] parameter is required and represents the callback function for click
  const CustomBackButton({super.key});

  @override
  State<StatefulWidget> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 30,
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)
        ),
        color: Color(0xFFECECEC),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]
      ),
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 20.0
      )
    );
  }
}
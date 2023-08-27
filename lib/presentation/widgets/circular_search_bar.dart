import 'package:flutter/material.dart';

/// Represents a custom search bar in the application.
class CircularSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final void Function(bool) onFocusChanged;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;

  /// Constructs a [CircularSearchBar] widget.
  ///
  /// The [controller] parameter is required and represents the text editing controller for the search bar.
  /// The [onFocusChanged] parameter is required and represents the callback function for focus change.
  /// The [onChanged] parameters is required and represents the callback function for search change.
  /// The [onSubmitted] parameter is required and represents the callback function for search submission.
  const CircularSearchBar({Key? key, required this.controller,
    required this.onFocusChanged, required this.onChanged,
    required this.onSubmitted}) : super(key: key);

  @override
  _CircularSearchBarState createState() => _CircularSearchBarState();
}

class _CircularSearchBarState extends State<CircularSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(onFocusChanged);
    _focusNode.dispose();

    super.dispose();
  }

  void onFocusChanged() {
    widget.onFocusChanged(_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
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
            onChanged: widget.onChanged,
            onSubmitted: (value) {
              _focusNode.unfocus();
              widget.onSubmitted(value);
            },
            focusNode: _focusNode,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
              ),
              hintText: 'Where would you like to go?',
            )
          )
        )
      ]
    );
  }
}

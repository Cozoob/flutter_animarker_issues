import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:city_transit/presentation/utils/size_config.dart';

class PlaceShortcut extends StatefulWidget {
  /// The icon to display.
  final IconData icon;
  /// The icon color.
  final Color iconColor;
  /// The optional text below Icon.
  final String? text;
  /// The optional textStyle for given text.
  final TextStyle? textStyle;
  /// The callback function to execute when the icon is tapped.
  final VoidCallback? onTap;

  const PlaceShortcut({
    Key? key,
    required this.icon,
    required this.iconColor,
    this.text,
    this.textStyle,
    this.onTap,
  }) : super(key: key);

  @override
  _PlaceShortcutState createState() => _PlaceShortcutState();
}

class _PlaceShortcutState extends State<PlaceShortcut> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration and vsync.
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Define the scale animation using a Tween and CurvedAnimation.
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        )
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is disposed.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Trigger the animation when the tap is initially detected.
      onTapDown: (_) {
        _animationController.forward();
      },
      // Reverse the animation when the tap is released.
      onTapUp: (_) {
        _animationController.reverse();
      },
      // Reverse the animation when the tap is canceled.
      onTapCancel: () {
        _animationController.reverse();
      },
      // Execute the onTap callback if it is provided.
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          SizeConfig().init(context);
          // Apply the scale animation to the container using Transform.scale.
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 95,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.iconColor,
                    ),
                    if (widget.text != null)
                      Expanded(
                        child: AutoSizeText(
                          widget.text!,
                          textAlign: TextAlign.center,
                          style: widget.textStyle,
                          maxLines: 2,
                          minFontSize: 9,
                          overflow: TextOverflow.ellipsis,
                        )
                      )
                  ]
                )
              )
            )
          );
        }
      )
    );
  }
}
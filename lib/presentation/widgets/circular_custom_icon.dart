import 'package:city_transit/presentation/utils/size_config.dart';
import 'package:flutter/material.dart';

/// Represents a custom circular icon with tap animation.
class CircularCustomIcon extends StatefulWidget {
  /// The icon to display.
  final IconData icon;

  /// The icon color.
  final Color iconColor;

  /// The background circle color
  final Color circleColor;

  /// The optional shadow color.
  final Color? shadowColor;

  /// The optional text below Icon.
  final String? text;

  /// The optional textStyle for given text.
  final TextStyle? textStyle;

  /// The callback function to execute when the icon is tapped.
  final VoidCallback? onTap;

  /// Constructor a [CircularCustomIcon] widget.
  ///
  /// The [icon] parameter is required.
  /// The [iconColor] parameter is required.
  /// The [circleColor] parameter is required.
  /// The [circleColor] parameter is optional.
  /// The [onTap] parameter is optional and can be null.
  const CircularCustomIcon({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    this.shadowColor,
    this.text,
    this.textStyle,
    this.onTap,
  }) : super(key: key);

  @override
  _CircularCustomIconState createState() => _CircularCustomIconState();
}

class _CircularCustomIconState extends State<CircularCustomIcon>
  with SingleTickerProviderStateMixin {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.screenWidth! * 0.13,
                  height: SizeConfig.screenHeight! * 0.07,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.circleColor,
                      boxShadow: [
                        BoxShadow(
                          color: widget.shadowColor == null
                              ? Colors.grey.withOpacity(0.5)
                              : widget.shadowColor!,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ]
                  ),
                  child: Icon(
                      widget.icon,
                      color: widget.iconColor
                  ),
                ),
                if (widget.text != null)
                  Padding(
                      padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.005),
                      child: Text(
                        widget.text!,
                        style: widget.textStyle,
                      ),
                  )
              ],
            )
          );
        },
      ),
    );
  }
}

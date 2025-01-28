import 'package:flutter/material.dart';

/// A customizable circular button widget that supports custom child widgets,
/// background color, borders, and size.
///
/// This widget is ideal for creating icon buttons or other circular-shaped buttons
/// with rich styling options.
///
/// ### Parameters:
/// - [onPressed]: The callback function to execute when the button is tapped (required).
/// - [borderWidth]: The width of the circular border. Defaults to `0.0`.
/// - [borderColor]: The color of the circular border. Defaults to `Colors.transparent`.
/// - [backgroundColor]: The background color of the button. Defaults to `Colors.transparent`.
/// - [child]: The widget to display inside the button (required).
/// - [width]: The width of the button. Defaults to `48.0`.
/// - [height]: The height of the button. Defaults to `48.0`.
/// - [padding]: The inner padding for the child widget. Defaults to `EdgeInsets.all(8.0)`.
class CustomIconBtn extends StatelessWidget {
  /// The callback function that is triggered when the button is tapped.
  final VoidCallback onPressed;

  /// The width of the border surrounding the button.
  final double borderWidth;

  /// The color of the border surrounding the button.
  final Color borderColor;

  /// The background color of the button.
  final Color backgroundColor;

  /// The child widget displayed inside the button, e.g., an icon or image.
  final Widget child;

  /// The width of the button. Defaults to `48.0`.
  final double width;

  /// The height of the button. Defaults to `48.0`.
  final double height;

  /// The padding applied inside the button around the child widget. Defaults to `EdgeInsets.all(8.0)`.
  final EdgeInsetsGeometry padding;

  /// Creates a `CustomIconBtn` widget.
  ///
  /// The [onPressed] and [child] parameters are required.
  const CustomIconBtn({
    super.key,
    required this.onPressed,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    required this.child,
    this.width = 48.0,
    this.height = 48.0,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent, // Transparent material for ripple effects
        child: InkWell(
          onTap: onPressed, // Trigger the provided callback when tapped
          child: Container(
            width: width, // Set the button width
            height: height, // Set the button height
            decoration: BoxDecoration(
              color: backgroundColor, // Background color of the button
              borderRadius: BorderRadius.circular(100.0), // Circular shape
              border: Border.all(
                color: borderColor, // Border color
                width: borderWidth, // Border width
              ),
            ),
            padding: padding, // Padding around the child widget
            child: child, // Child widget displayed inside the button
          ),
        ),
      ),
    );
  }
}

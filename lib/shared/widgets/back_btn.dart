import 'package:flutter/material.dart';

/// A custom back button widget that provides a circular button with
/// an arrow icon to navigate back to the previous screen.
///
/// The icon's color can be customized by passing a `color` parameter.
class BackBtn extends StatelessWidget {
  /// The color of the back arrow icon. Defaults to white (`Color(0xFFFFFFFF)`).
  final Color color;

  /// Creates a `BackBtn` widget.
  ///
  /// - [color]: The color of the back arrow icon (optional, default is white).
  const BackBtn({super.key, this.color = const Color(0xFFFFFFFF)});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent, // Transparent background for the button
        child: InkWell(
          onTap: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          child: Icon(
            Icons.arrow_back_ios_rounded, // Back arrow icon
            color: color, // Set the icon color
            size: 26.0, // Size of the icon
          ),
        ),
      ),
    );
  }
}

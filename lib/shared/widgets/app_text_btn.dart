import 'package:flutter/material.dart';

/// A customizable text button widget that triggers an action when tapped.
///
/// The button displays a text label and provides options for customizing
/// the text style, including color, font size, and weight.
///
/// ### Parameters:
/// - [text]: The text displayed on the button (required).
/// - [onPress]: The callback function to execute when the button is tapped (required).
/// - [color]: The color of the text (required).
/// - [fontSize]: Optional font size of the text. Defaults to `13.0`.
/// - [fontWeight]: Optional font weight of the text. Defaults to `FontWeight.w400`.
class AppTextBtn extends StatelessWidget {
  /// The text displayed on the button.
  final String text;

  /// The callback function that is triggered when the button is tapped.
  final VoidCallback onPress;

  /// The color of the text.
  final Color color;

  /// The font size of the text. Defaults to `13.0` if not provided.
  final double? fontSize;

  /// The font weight of the text. Defaults to `FontWeight.w400` if not provided.
  final FontWeight? fontWeight;

  /// Creates an `AppTextBtn` widget.
  ///
  /// All parameters except [fontSize] and [fontWeight] are required.
  const AppTextBtn({
    super.key,
    required this.text,
    required this.onPress,
    required this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Transparent background for the button
      child: InkWell(
        onTap: onPress, // Trigger the provided callback when tapped
        child: Text(
          text,
          style: TextStyle(
            color: color, // Set the text color
            fontSize: fontSize ?? 13.0, // Default font size is 13.0
            fontWeight: fontWeight ?? FontWeight.w400, // Default font weight is w400
          ),
        ),
      ),
    );
  }
}

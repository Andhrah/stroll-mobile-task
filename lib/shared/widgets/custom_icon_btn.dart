import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderWidth;
  final Color borderColor;
  final Color backgroundColor;
  final Widget child;

  const CustomIconBtn({
    super.key,
    required this.onPressed,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

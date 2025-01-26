import 'package:flutter/material.dart';

class Wave extends StatelessWidget {
  final List<double> amplitudes;
  final bool isRecording; // New parameter to track recording state
  final double barWidth;
  final double barSpacing;
  final double maxHeight;
  final Color color;

  const Wave({
    super.key,
    required this.amplitudes,
    required this.isRecording, // Pass recording state
    this.barWidth = 2,
    this.barSpacing = 2.0,
    this.maxHeight = 100.0,
    this.color = const Color(0xFF36393E),
  });

  @override
  Widget build(BuildContext context) {
    final double waveformWidth = MediaQuery.of(context).size.width * 1;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: waveformWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: isRecording
            ? amplitudes.map((amplitude) {
                return Container(
                  width: barWidth,
                  height: amplitude, // Amplitude-based height
                  margin: EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                );
              }).toList()
            : [
              _buildFlatLine(context),
              ], // Show horizontal line if not recording
      ),
    );
  }

  Widget _buildFlatLine(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.96,
      height: 1.0, // Flat line height
      decoration: BoxDecoration(
        color: Color(0xFF36393E),
      ),
    );
  }
}

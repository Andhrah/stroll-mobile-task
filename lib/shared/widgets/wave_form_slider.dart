import 'package:flutter/material.dart';

/// A widget that renders a waveform slider, commonly used for audio visualization
/// during playback or recording.
///
/// The waveform consists of a series of vertical bars, with their heights determined
/// by the provided amplitude values. The slider can visually indicate the playback
/// progress or recording activity.
///
/// ### Parameters:
/// - [amplitudes]: A list of double values representing the heights of the waveform bars (required).
/// - [isRecording]: A boolean flag to indicate if the waveform is in recording mode (required).
/// - [barWidth]: The width of each waveform bar. Defaults to `2.0`.
/// - [barSpacing]: The horizontal spacing between bars. Defaults to `2.0`.
/// - [maxHeight]: The maximum height of the waveform container. Defaults to `100.0`.
/// - [color]: The default color of the inactive waveform bars. Defaults to `Color(0xFF36393E)`.
/// - [activeColor]: The color of the active waveform bars during playback. Defaults to `Color(0xFFBFBDFF)` if not provided.
/// - [inactiveColor]: The color of the inactive waveform bars. Defaults to [color] if not provided.
/// - [position]: The current playback position as a [Duration].
/// - [duration]: The total duration of the audio as a [Duration].
class WaveFormSlider extends StatelessWidget {
  /// A list of double values representing the heights of the waveform bars.
  final List<double> amplitudes;

  /// A flag indicating if the waveform is in recording mode.
  final bool isRecording;

  /// The width of each waveform bar.
  final double barWidth;

  /// The spacing between waveform bars.
  final double barSpacing;

  /// The maximum height of the waveform container.
  final double maxHeight;

  /// The color of the inactive waveform bars.
  final Color color;

  /// The color of the active waveform bars during playback.
  final Color? activeColor;

  /// The color of the inactive waveform bars (overrides [color] if provided).
  final Color? inactiveColor;

  /// The current playback position in the audio.
  final Duration? position;

  /// The total duration of the audio.
  final Duration? duration;

  /// Creates a `WaveFormSlider` widget.
  ///
  /// The [amplitudes] and [isRecording] parameters are required.
  const WaveFormSlider({
    super.key,
    required this.amplitudes,
    required this.isRecording,
    this.barWidth = 2.0,
    this.barSpacing = 2.0,
    this.maxHeight = 100.0,
    this.color = const Color(0xFF36393E),
    this.activeColor,
    this.inactiveColor,
    this.position,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the total width for the waveform
    final double waveformWidth = MediaQuery.of(context).size.width;
    final int barCount = amplitudes.length;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06, // Fixed height for the waveform
      width: waveformWidth, // Full-width waveform
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the bars
        children: List.generate(barCount, (index) {
          // Calculate playback progress as a percentage
          final double progress = (position?.inMilliseconds ?? 0) / (duration?.inMilliseconds ?? 1);
          // Determine if the current bar is part of the active progress
          final bool isActive = index / barCount <= progress;

          return Container(
            width: barWidth, // Set bar width
            height: amplitudes[index], // Set bar height based on amplitude
            margin: EdgeInsets.symmetric(horizontal: barSpacing), // Set spacing between bars
            decoration: BoxDecoration(
              color: isActive
                  ? (activeColor ?? const Color(0xFFBFBDFF)) // Active bar color
                  : (inactiveColor ?? color), // Inactive bar color
              borderRadius: BorderRadius.circular(20.0), // Rounded edges for bars
            ),
          );
        }),
      ),
    );
  }
}

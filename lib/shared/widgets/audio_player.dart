import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroll/shared/widgets/app_text_btn.dart';
import 'package:stroll/shared/widgets/wave_form_slider.dart';

class AudioPlayer extends StatefulWidget {
  /// Path from where to play recorded audio
  final String source;

  /// Callback when audio file should be removed
  /// Setting this to null hides the delete button
  final VoidCallback onDelete;

  const AudioPlayer({
    super.key,
    required this.source,
    required this.onDelete,
  });

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  static const double _controlSize = 64;

  final _audioPlayer = ap.AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;

  List<double> _savedAmplitudeData = []; // Holds the saved amplitude data

  int _currentBarIndex = 0;
  final Color _highlightedColor = const Color(0xFFBFBDFF); // Highlight color for the current bar

  @override
  void initState() {
    // Load amplitude data from SharedPreferences (optional, based on your use case)
    _loadAmplitudeData();
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
    });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
        // Calculate the corresponding bar index
        _currentBarIndex = (position.inMilliseconds / 300).floor();
        // Ensure the index is within the bounds of the amplitude data list
        if (_currentBarIndex >= _savedAmplitudeData.length) {
          _currentBarIndex = _savedAmplitudeData.length - 1;
        }
      }),
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );

    _audioPlayer.setSource(_source);

    super.initState();
  }

  // Load all amplitudes from SharedPreferences
  Future<void> _loadAmplitudeData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? stringValues = prefs.getStringList('_savedAmplitudeData');

    if (stringValues != null) {
      _savedAmplitudeData = stringValues.map((e) => double.parse(e)).toList();

      setState(() {
        _savedAmplitudeData = stringValues.map((e) => double.parse(e)).toList();
      });
    }
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              '${_position != null ? formatDuration(_position!) : "00:00"} / ${_duration != null ? formatDuration(_duration!) : "00:00"}',
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFF5F5F5),
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 30.0),
            WaveFormSlider(
              amplitudes: _savedAmplitudeData, // Use 2.0 if empty
              isRecording: true, // Pass the recording state
              barWidth: 1.0,
              barSpacing: 2.0,
              color: Color(0xFF36393E),
              activeColor: _highlightedColor,
              position: _position,
              duration: _duration,
            ),

            SizedBox(height: 30.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppTextBtn(
                    text: 'Delete',
                    onPress: () {
                      if (_audioPlayer.state != ap.PlayerState.playing) {
                        stop().then((value) => widget.onDelete());
                      } else {
                        // Do nothing when audio is playing
                      }
                    },
                    color: _audioPlayer.state == ap.PlayerState.playing
                        ? Color.fromRGBO(255, 255, 255, 0.3) // Gray color when playing
                        : Color.fromRGBO(255, 255, 255, 1), // White color when not playing
                  ),

                  _buildControl(),

                  AppTextBtn(
                    text: 'Submit',
                    onPress: () => {},
                    color: _audioPlayer.state == ap.PlayerState.playing
                        ? Color.fromRGBO(255, 255, 255, 0.3) // Gray color when playing
                        : Color.fromRGBO(255, 255, 255, 1), // White color when not playing
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildControl() {
    Widget icon;
    Color color;

    if (_audioPlayer.state == ap.PlayerState.playing) {
      icon = SvgPicture.asset(
        'assets/icons/pause.svg',
        width: 64.0,
        height: 64.0,
      );
      color = Colors.transparent;
    } else {
      icon = SvgPicture.asset(
        'assets/icons/play.svg',
        width: 64.0,
        height: 64.0,
      );
      color = Colors.transparent;
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
              SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            if (_audioPlayer.state == ap.PlayerState.playing) {
              pause();
            } else {
              play();
            }
          },
        ),
      ),
    );
  }

  Future<void> play() => _audioPlayer.play(_source);

  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() {});
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {});
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Source get _source =>
      kIsWeb ? ap.UrlSource(widget.source) : ap.DeviceFileSource(widget.source);
}

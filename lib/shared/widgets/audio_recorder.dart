import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroll/shared/widgets/app_text_btn.dart';
import 'package:stroll/shared/widgets/wave_form.dart';

import '../../platform/audio_recorder_platform.dart';

class Recorder extends StatefulWidget {
  final void Function(String path) onStop;

  const Recorder({super.key, required this.onStop});

  @override
  State<Recorder> createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> with AudioRecorderMixin {
  int _recordDuration = 0;
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  final List<double> _amplitudeValues = [];
  final double maxDbfs = 1.0; // loudest volume
  final double minDbfs = -40; // quietest volume
  final List<double> _savedAmplitudeData = []; // Holds the saved amplitude data

  @override
  void initState() {
    _audioRecorder = AudioRecorder();

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      double normalizedHeight =
          (amp.current - minDbfs) / (maxDbfs - minDbfs) * 40; // Normalize
      if (normalizedHeight < 0) {
        normalizedHeight = normalizedHeight * -1;
      }
      if (normalizedHeight < 2) {
        normalizedHeight = 2;
      }
      setState(() {
        _amplitudeValues.add(normalizedHeight);
        _savedAmplitudeData.add(normalizedHeight);
        if (_amplitudeValues.length > 70) {
          _amplitudeValues.removeAt(0); // Keep only the latest 70 values
        }
      });
    });

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.aacLc;

        if (!await _isEncoderSupported(encoder)) {
          return;
        }

        const config = RecordConfig(encoder: encoder, numChannels: 1);

        // Record to file
        await recordFile(_audioRecorder, config);

        _recordDuration = 0;

        _amplitudeValues.clear(); // Clear amplitude values when starting a new recording

        _startTimer();
      }
    } catch (err) {
      if (kDebugMode) {
        debugPrint('This error is coming from recorder widget $err');
      }
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();

    if (path != null) {
      widget.onStop(path);

      downloadWebData(path);
    }

    // Save all amplitude data to SharedPreferences
    await _saveAllAmplitudeData();
  }

  /// Save all amplitudes to SharedPreferences
  Future<void> _saveAllAmplitudeData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the key exists and remove the old data if it does
    final List<String>? data = prefs.getStringList('_savedAmplitudeData');

    if (data == null) {
      await prefs.remove('_savedAmplitudeData');
    }

    // Convert List<double> to List<String> for storage
    List<String> stringValues = _savedAmplitudeData.map((e) => e.toString()).toList();

    // Save the new data
    await prefs.setStringList('_savedAmplitudeData', stringValues);
  }

  Future<void> _pause() => _audioRecorder.pause();

  Future<void> _resume() => _audioRecorder.resume();

  void _updateRecordState(RecordState recordState) {
    setState(() => _recordState = recordState);

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        _recordDuration = 0;
        break;
    }
  }


  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _audioRecorder.isEncoderSupported(encoder);

    if (!isSupported) {
      // Only print in debug mode
      if (kDebugMode) {
        debugPrint('${encoder.name} is not supported on this platform.');
        debugPrint('Supported encoders are:');

        for (final e in AudioEncoder.values) {
          if (await _audioRecorder.isEncoderSupported(e)) {
            debugPrint('- ${e.name}');
          }
        }
      }
    }
    return isSupported;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildText(),
            SizedBox(height: 30.0),
            Wave(
              amplitudes: _amplitudeValues, // Use 2.0 if empty
              isRecording: _recordState == RecordState.record, // Pass the recording state
              barWidth: 2.0,
              barSpacing: 2.0,
              color: Color(0xFF36393E),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AppTextBtn(
                    text: 'Delete',
                    onPress: () => {},
                    color: Color.fromRGBO(255, 255, 255, 0.2),
                  ),

                  _buildRecordStopControl(),

                  AppTextBtn(
                    text: 'Submit',
                    onPress: () => {},
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    // _ampTimer?.cancel();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Widget icon;
    late Color color;

    if (_recordState != RecordState.stop) {
      const SizedBox(width: 20);
      icon = SvgPicture.asset(
        'assets/icons/stop.svg',
        width: 64.0,
        height: 64.0,
      );
      color = Colors.transparent;
    } else {
      final theme = Theme.of(context);
      icon = SvgPicture.asset(
        'assets/icons/record.svg',
        width: 64.0,
        height: 64.0,
      );
      color = color = Colors.transparent;
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 64, height: 64, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return const SizedBox.shrink();
    }

    late Widget icon;
    late Color color;

    if (_recordState == RecordState.record) {
      const SizedBox(width: 20);
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
          child: SizedBox(width: 64, height: 64, child: icon),
          onTap: () {
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }

    return const Text(
      '00:00',
      style: TextStyle(
        fontSize: 13.0,
        color: Color(0xFF5D6369),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(
        fontSize: 13.0,
        color: Color(0xFFBFBDFF),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }
}

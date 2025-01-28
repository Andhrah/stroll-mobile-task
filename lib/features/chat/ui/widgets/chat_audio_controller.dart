import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:stroll/shared/widgets/app_text_btn.dart';
import 'package:stroll/shared/widgets/record_stop_control.dart';

class ChatAudioControl extends StatefulWidget {
  final bool isRecording;

  const ChatAudioControl(
    {super.key, 
    required this.isRecording, 
  });

  @override
  _ChatAudioControlState createState() => _ChatAudioControlState();
}

class _ChatAudioControlState extends State<ChatAudioControl> {
  RecordState _recordState = RecordState.stop;
  @override
  void initState() {
    super.initState();
    _recordState = widget.isRecording ? RecordState.record : RecordState.stop;
  }
  

  @override
  Widget build(BuildContext context) {
    return (Row(
      children: <Widget>[
        AppTextBtn(
          text: 'Delete',
          onPress: () => {},
          color: _recordState == RecordState.stop
              ? Color.fromRGBO(255, 255, 255, 0.2)
              : Colors.white, // Opacity for stop, full color otherwise
        ),
        // RecordStopControl(
        //   isRecording: _recordState != RecordState.stop,
        //   onTap: (_recordState != RecordState.stop) ? _stop() : _start(),
        // ),
        AppTextBtn(
          text: 'Submit',
          onPress: () => {},
          color: Color.fromRGBO(255, 255, 255, 0.2),
        ),
      ],
    ));
  }
}

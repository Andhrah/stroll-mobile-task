import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroll/features/chat/ui/screens/chat_recording_screen.dart';
import 'package:stroll/shared/widgets/custom_icon_btn.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hi 👋🏽 this is chat screen',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          CustomIconBtn(
            backgroundColor: Colors.transparent,
            borderColor: const Color(0xFF8B88EF),
            borderWidth: 2.2,
            onPressed: () {
              // open chat recording screen
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ChatRecordingScreen(),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/mic.svg',
              width: 19.0,
              height: 26.0,
            ),
          ),
        ],
      )),
    );
  }
}

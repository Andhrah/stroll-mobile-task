import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:record/record.dart';
import 'package:stroll/features/chat/ui/widgets/chat_audio_controller.dart';
import 'package:stroll/shared/widgets/anime.dart';
import 'package:stroll/shared/widgets/app_text_btn.dart';
import 'package:stroll/shared/widgets/audio_player.dart';
import 'package:stroll/shared/widgets/audio_recorder.dart';
import 'package:stroll/shared/widgets/custom_icon_btn.dart';

class ChatRecordingScreen extends StatefulWidget {
  const ChatRecordingScreen({super.key});

  @override
  _ChatRecordingScreenState createState() => _ChatRecordingScreenState();
}

class _ChatRecordingScreenState extends State<ChatRecordingScreen> {
  final List<double> _amplitudes = [];
  // final record = AudioRecorder();

  bool showPlayer = false;
  String? audioPath;


  @override
  void initState() {
    showPlayer = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: <Widget>[
        AspectRatio(
          aspectRatio: 2.5 / 4,
          child: Container(
            width: screenWidth,
            height: screenHeight * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/user_cover_img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/images/fade.svg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 52.0, 5.0, 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ..._buildFlatLine(),
                ],
              ),

              const SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    color: const Color(0xFFFFFFFF),
                    size: 26.0,
                  ),
                  const Text(
                    'Angelina, 28',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFF5F5F5),
                      fontWeight: FontWeight.w700,
                      height: 2.8,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.ellipsis,
                    color: const Color(0xFFFFFFFF),
                    size: 26.0,
                  ),
                ],
              ),

              Spacer(),

              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF121517),
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile_img.png',
                        width: 34.0,
                        height: 34.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35.0,
                    child: Container(
                      height: 22.0,
                      width: 94.0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(18, 21, 24, 0.9),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Stroll Question',
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      'What is your favorite time of the day?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFFF5F5F5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      '“Mine is definitely the peace in the morning.”',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(203, 201, 255, 0.6),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 35.0),

              // LineAnimationScreen(), 
              

              Container(
                height:  MediaQuery.of(context).size.width * 0.48,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: showPlayer
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: AudioPlayer(
                          source: audioPath!,
                          onDelete: () {
                            setState(() => showPlayer = false);
                          },
                        ),
                      )
                    : Recorder(
                        onStop: (path) {
                          if (kDebugMode) print('Recorded file path: $path');
                          setState(() {
                            audioPath = path;
                            showPlayer = true;
                          });
                        },
                      ),
                ),
              ),

             
              SizedBox(height: 25.0),
              AppTextBtn(
                text: 'Unmatch',
                onPress: () => {},
                color: Color.fromRGBO(255, 41, 41, 0.4),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  List<Widget> _buildFlatLine() {
    return List.generate(2, (index) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: index == 0 ? Colors.white : Color.fromRGBO(135, 135, 135, 0.5), // White for the first container
          borderRadius: BorderRadius.circular(20.0),
        ),
      );
    });
  }

}

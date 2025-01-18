import 'package:flutter/material.dart';

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
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BonfireScreen extends StatelessWidget {
  const BonfireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hi 👋🏽 this is bonfire screen'),
          ],
        )
      ),
    );
  }
}

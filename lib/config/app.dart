import 'package:flutter/material.dart';
import 'package:stroll/routers/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stroll App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'ProximaNova',
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

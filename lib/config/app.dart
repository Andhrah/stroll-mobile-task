import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroll/features/bonfire/states/bonfire_bloc.dart';
import 'package:stroll/features/bonfire/states/bonfire_event.dart';
import 'package:stroll/routers/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BonfireBloc()..add(const OptionSelected('')),
        ),
      ],
      child: MaterialApp.router(
        title: 'Stroll App',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'ProximaNova',
        ),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> profileRoutes = [
  GoRoute(
    path: '/profile',
    builder: (BuildContext context, GoRouterState state) {
      return Text('I am a dummy screen');
    },
  ),
];

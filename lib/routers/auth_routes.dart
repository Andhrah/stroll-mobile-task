import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> authRoutes = [
  GoRoute(
    path: '/auth',
    builder: (BuildContext context, GoRouterState state) {
      return Text('I am a dummy screen');
    },
  ),
];

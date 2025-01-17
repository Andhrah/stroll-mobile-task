import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> mainRoutes = [
  GoRoute(
    path: '/main',
    builder: (BuildContext context, GoRouterState state) {
      return Text('I am a dummy screen');
    },
  ),
];

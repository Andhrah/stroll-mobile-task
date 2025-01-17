import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stroll/routers/main_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/main',
  routes: <RouteBase>[
    ...mainRoutes,
  ],

  errorBuilder: (BuildContext context, GoRouterState state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found',
      ),
    ),
  ),
);

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:stroll/routers/app_tabs.dart';

final List<RouteBase> mainRoutes = [
  GoRoute(
    path: '/tabs',
    builder: (BuildContext context, GoRouterState state) {
      return AppTabs();
    },
  ),
];

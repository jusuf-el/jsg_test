import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jsg_test/modules/home/home_view.dart';
import 'package:jsg_test/modules/photos/photos_view.dart';

class JSGuruRouter {
  static final GoRouter goRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeView();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'photos',
            builder: (BuildContext context, GoRouterState state) {
              return const PhotosView();
            },
          ),
        ],
      ),
    ],
  );
}

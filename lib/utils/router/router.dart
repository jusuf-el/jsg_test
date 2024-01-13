import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jsg_test/data/models/post.dart';
import 'package:jsg_test/modules/home/view/home_view.dart';
import 'package:jsg_test/modules/photos/view/photos_view.dart';
import 'package:jsg_test/modules/post_details/view/post_details_view.dart';

class JSGuruRouter {
  static const String home = 'home';
  static const String postDetails = 'post_details';
  static const String photos = 'photos';

  static final GoRouter goRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
        routes: <RouteBase>[
          GoRoute(
            path: postDetails,
            name: postDetails,
            builder: (BuildContext context, GoRouterState state) {
              return PostDetailsView(state.extra as Post);
            },
          ),
          GoRoute(
            path: photos,
            name: photos,
            builder: (BuildContext context, GoRouterState state) {
              return const PhotosView();
            },
          ),
        ],
      ),
    ],
  );
}

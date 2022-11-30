import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/genre/genre.dart';
import '../screens/details/details_screen.dart';
import '../screens/error/error_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'route_names.dart';
import 'route_paths.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    errorBuilder: (context, state) => ErrorScreen(key: state.pageKey),
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => SplashScreen(key: state.pageKey),
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            pageBuilder: (context, state) => animationTransitionNavigation(
              context: context,
              state: state,
              child: HomeScreen(key: state.pageKey),
            ),
            routes: [
              GoRoute(
                path: RoutePaths.details,
                name: RouteNames.details,
                pageBuilder: (context, state) => animationTransitionNavigation(
                  context: context,
                  state: state,
                  child: DetailsScreen(
                    key: state.pageKey,
                    id: state.params['id'],
                    listGenres: state.extra as List<Genre>?,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);

// Animation transition from one screen to another
CustomTransitionPage animationTransitionNavigation<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 600),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );

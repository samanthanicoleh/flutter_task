import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/colors.dart';
import 'route/go_router_provider.dart';
import 'services/hive_service.dart';

Future<void> main() async {
  runApp(
    const ProviderScope(
      child: FlutterTaskApp(),
    ),
  );
}

class FlutterTaskApp extends ConsumerWidget {
  const FlutterTaskApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return ref.watch(hiveStateProvider).when(
          data: (data) => ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) => MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
              routerDelegate: router.routerDelegate,
              title: 'Flutter Task',
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.secondaryDarkBlue,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: AppColors.primaryColor,
                  secondary: AppColors.secondaryDarkBlue,
                ),
              ),
            ),
          ),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

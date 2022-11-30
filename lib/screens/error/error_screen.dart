import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../route/route_names.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.secondaryDarkBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Page not found. Please retry.',
                style: AppTextStyles.subtitle,
              ),
              ElevatedButton(
                onPressed: () => context.replaceNamed(RouteNames.home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FletesFlex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.table,
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();
        return ColoredBox(
          color: AppColors.border,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

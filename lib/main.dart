import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/utils/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'JSGuru Assessment Task',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorConstants.appBarBackground,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: JSGuruRouter.goRouter,
    );
  }
}

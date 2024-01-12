import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/modules/home/provider/home_provider.dart';
import 'package:jsg_test/modules/photos/provider/photos_provider.dart';
import 'package:jsg_test/utils/router/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<PhotosProvider>(create: (_) => PhotosProvider()),
      ],
      child: const MyApp(),
    ),
  );
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

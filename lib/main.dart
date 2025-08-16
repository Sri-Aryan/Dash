import 'package:dash/domain/constants/appcolors.dart';
import 'package:dash/repository/screens/splash/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dash',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.scaffoldbackground),
          useMaterial3: false,
        ),
        home: SplashScreen());
  }
}
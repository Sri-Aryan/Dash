import 'package:dash/domain/constants/appcolors.dart';
import 'package:dash/repository/cart/cart_bloc.dart';
import 'package:dash/repository/screens/splash/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> CartBloc())
      ],
      child: MaterialApp(
          title: 'Dash',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.scaffoldbackground),
            useMaterial3: false,
          ),
          home: SplashScreen()
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_task/providers/player_provider.dart';
import 'package:flutter_task/providers/profile_form_provider.dart';

import 'package:flutter_task/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ChangeNotifierProvider(create: (_) => ProfileFormProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          bottomNavigationBarTheme:
              BottomNavigationBarThemeData(backgroundColor: Colors.amberAccent),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}

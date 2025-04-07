import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizify_ai/screens/welcome_screen.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      title: "Quizify",
      home: WelcomeScreen(),
    );
  }
}

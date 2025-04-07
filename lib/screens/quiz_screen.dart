import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String userName = "";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: Text("data")));
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizify_ai/screens/quiz_screen.dart';
import 'package:quizify_ai/utils/constants.dart';

class JobRoleScreen extends StatefulWidget {
  const JobRoleScreen({super.key});

  @override
  _JobRoleScreenState createState() => _JobRoleScreenState();
}

class _JobRoleScreenState extends State<JobRoleScreen> {
  final TextEditingController _controller = TextEditingController();

  void _startQuiz() async {
    final jobRole = _controller.text.trim();
    if (jobRole.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Colors.blueAccent),
                SizedBox(height: 20),
                Text(
                  "Loading questions...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
    );

    final questions = await fetchQuestions(jobRole);

    Navigator.pop(context); // Remove loading indicator

    if (!mounted) return;

    if (questions.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load quiz questions.")));
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                QuizScreen(questions: questions),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  Future<List<Question>> fetchQuestions(String jobRole) async {
    final prompt =
        "Generate 10 multiple-choice questions for a $jobRole interview. Each question should have 1 correct answer and 3 incorrect options. Format the response as a valid JSON array of objects with 'question', 'options' (as array), and 'answer'.";

    try {
      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=$apiKey",
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        }),
      );

      final data = json.decode(response.body);
      if (kDebugMode) {
        print("Gemini API Raw Response: $data");
      }

      final rawText = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
      if (rawText == null) return [];

      final cleaned =
          rawText.replaceAll('```json', '').replaceAll('```', '').trim();

      final parsed = json.decode(cleaned);

      return (parsed as List).map((q) => Question.fromJson(q)).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Job Role")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let's get started!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Job Role',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white38),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: _startQuiz, child: Text("Start Quiz")),
          ],
        ),
      ),
    );
  }
}

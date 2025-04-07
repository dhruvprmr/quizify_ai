import 'package:flutter/material.dart';
import 'package:quizify_ai/screens/job_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz, size: 100, color: Colors.blueAccent),
              SizedBox(height: 30),
              Text(
                "Welcome to Quizify AI!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => JobRoleScreen()),
                    ),
                child: Text("Start Quiz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

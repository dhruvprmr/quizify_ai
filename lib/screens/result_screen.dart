import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percentage = (score / total) * 100;
    final message = percentage >= 90 ? "🎉 Congratulations!" : "❌ Try Again!";

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Result",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("Score: $score / $total", style: TextStyle(fontSize: 22)),
              SizedBox(height: 16),
              Text(
                "Percentage: ${percentage.toStringAsFixed(2)}%",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 24),
              Text(
                message,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: percentage >= 90 ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed:
                    () => Navigator.popUntil(context, (route) => route.isFirst),
                icon: Icon(Icons.restart_alt),
                label: Text("Play Again"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

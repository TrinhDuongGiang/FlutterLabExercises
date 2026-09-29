import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class Question {
  final String text;
  final bool answer;

  Question(this.text, this.answer);
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final questions = [
    Question('Flutter được phát triển bởi Google.', true),
    Question('Dart là ngôn ngữ của Flutter.', true),
    Question('Flutter chỉ chạy trên Android.', false),
    Question('Widget là thành phần cơ bản của Flutter.', true),
    Question('setState dùng để cập nhật UI.', true),
  ];

  int index = 0;
  List<Icon> score = [];

  void answer(bool userAnswer) {
    setState(() {
      if (userAnswer == questions[index].answer) {
        score.add(const Icon(Icons.check, color: Colors.green));
      } else {
        score.add(const Icon(Icons.close, color: Colors.red));
      }

      index++;

      if (index == questions.length) {
        index = 0;
        score.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Quizzler')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    questions[index].text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => answer(true),
                child: const Text(
                  'ĐÚNG',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              TextButton(
                onPressed: () => answer(false),
                child: const Text(
                  'SAI',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Row(children: score),
            ],
          ),
        ),
      ),
    );
  }
}
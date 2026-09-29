import 'package:flutter/material.dart';

void main() => runApp(const Destini());

class Story {
  String text;
  String choice1;
  String choice2;
  int next1;
  int next2;

  Story(
    this.text,
    this.choice1,
    this.choice2,
    this.next1,
    this.next2,
  );
}

class Destini extends StatefulWidget {
  const Destini({super.key});

  @override
  State<Destini> createState() => _DestiniState();
}

class _DestiniState extends State<Destini> {
  int index = 0;

  final stories = [
    Story(
      'Bạn đang đi trong một khu rừng.',
      'Đi theo con đường bên trái',
      'Đi theo con đường bên phải',
      1,
      2,
    ),
    Story(
      'Bạn gặp một ngôi nhà bí ẩn.',
      'Gõ cửa',
      'Bỏ đi',
      3,
      4,
    ),
    Story(
      'Bạn tìm thấy một chiếc rương.',
      'Mở rương',
      'Bỏ qua',
      3,
      4,
    ),
    Story(
      'Bạn tìm thấy kho báu! Bạn thắng!',
      'Chơi lại',
      '',
      0,
      0,
    ),
    Story(
      'Bạn trở về nhà an toàn.',
      'Chơi lại',
      '',
      0,
      0,
    ),
  ];

  void choose(int next) {
    setState(() {
      index = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final story = stories[index];
    final ending = story.choice2.isEmpty;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Destini')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    story.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => choose(story.next1),
                child: Text(story.choice1),
              ),
              Visibility(
                visible: !ending,
                child: ElevatedButton(
                  onPressed: () => choose(story.next2),
                  child: Text(story.choice2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
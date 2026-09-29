import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Xylophone());

class Xylophone extends StatelessWidget {
  const Xylophone({super.key});

  final List<Color> colors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple,
  ];

  void play(int number) {
    final player = AudioPlayer();
    player.play(AssetSource('note$number.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: List.generate(
              7,
              (index) => Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: colors[index],
                    shape: const RoundedRectangleBorder(),
                  ),
                  onPressed: () => play(index + 1),
                  child: const SizedBox(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
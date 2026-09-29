import 'package:flutter/material.dart';

void main() => runApp(const BMIApp());

class BMIApp extends StatefulWidget {
  const BMIApp({super.key});

  @override
  State<BMIApp> createState() => _BMIAppState();
}

class _BMIAppState extends State<BMIApp> {
  double height = 170;
  int weight = 65;
  int age = 20;
  bool male = true;
  String result = '';

  void calculate() {
    final bmi = weight / ((height / 100) * (height / 100));

    setState(() {
      if (bmi < 18.5) {
        result = 'Underweight\nBMI: ${bmi.toStringAsFixed(1)}';
      } else if (bmi < 25) {
        result = 'Normal\nBMI: ${bmi.toStringAsFixed(1)}';
      } else {
        result = 'Overweight\nBMI: ${bmi.toStringAsFixed(1)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('BMI Calculator')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: result.isEmpty
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Male'),
                            value: true,
                            groupValue: male,
                            onChanged: (v) =>
                                setState(() => male = true),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Female'),
                            value: false,
                            groupValue: male,
                            onChanged: (v) =>
                                setState(() => male = false),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'Height: ${height.toInt()} cm',
                      style: const TextStyle(fontSize: 20),
                    ),

                    Slider(
                      min: 120,
                      max: 220,
                      value: height,
                      onChanged: (v) =>
                          setState(() => height = v),
                    ),

                    Text('Weight: $weight kg'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () =>
                              setState(() => weight--),
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$weight',
                          style: const TextStyle(fontSize: 25),
                        ),
                        IconButton(
                          onPressed: () =>
                              setState(() => weight++),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),

                    Text('Age: $age'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () =>
                              setState(() => age--),
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$age',
                          style: const TextStyle(fontSize: 25),
                        ),
                        IconButton(
                          onPressed: () =>
                              setState(() => age++),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: calculate,
                      child: const Text('CALCULATE'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'YOUR RESULT',
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => result = ''),
                      child: const Text('RE-CALCULATE'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              const SizedBox(height: 15),
              const Text(
                'Trinh Duong Giang',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const ListTile(
                  leading: Icon(Icons.phone, color: Colors.blue),
                  title: Text('+84 123 456 789'),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: const ListTile(
                  leading: Icon(Icons.email, color: Colors.blue),
                  title: Text('giang@example.com'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

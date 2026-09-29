import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MagicBallApp());

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MagicBall(),
    );
  }
}

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  int answer = 1;

  void ask() {
    setState(() {
      answer = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          'Magic 8 Ball',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bấm trực tiếp vào bóng cũng đổi câu trả lời
            GestureDetector(
              onTap: ask,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 1. Quả bóng đen bên ngoài (với gradient tạo hiệu ứng 3D và bóng đổ)
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        center: Alignment(-0.3, -0.3),
                        radius: 0.8,
                        colors: [
                          Color(0xFF4A4A4A), // Điểm sáng phản chiếu nhẹ
                          Color(0xFF1A1A1A),
                          Colors.black,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 20,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                  ),

                  // 2. Viền khuyết sâu ở giữa (tạo độ lõm vào trong quả bóng)
                  Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0D1B2A),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 2,
                      ),
                    ),
                  ),

                  // 3. Ảnh từ assets nằm lọt thỏm ngay tâm vùng khuyết
                  ClipOval(
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: Image.asset(
                        'assets/ball$answer.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Nút bấm ASK
            ElevatedButton.icon(
              onPressed: ask,
              icon: const Icon(Icons.help_outline),
              label: const Text(
                'ASK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
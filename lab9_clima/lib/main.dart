
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final cityController = TextEditingController();

  String city = 'Da Nang';
  String temp = '--';
  String description = '';
  String icon = '';
  String error = '';
  bool loading = false;

  final String apiKey = '6d32e02f0f25a2b11839e96ca99a2317';

  // Lấy thời tiết theo tên thành phố
  Future<void> getWeather(String cityName) async {
    setState(() {
      loading = true;
      error = '';
    });

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
      '?q=$cityName'
      '&appid=$apiKey'
      '&units=metric'
      '&lang=vi',
    );

    try {
      final response = await http.get(url);

      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          city = data['name'];
          temp = data['main']['temp'].toStringAsFixed(1);
          description = data['weather'][0]['description'];
          icon = data['weather'][0]['icon'];
          loading = false;
        });
      } else {
        final data = jsonDecode(response.body);

        setState(() {
          error = data['message'] ?? 'Có lỗi xảy ra';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Lỗi kết nối: $e';
        loading = false;
      });
    }
  }

  // Lấy thời tiết theo vị trí hiện tại
  Future<void> getCurrentLocation() async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      final position = await Geolocator.getCurrentPosition();

      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather'
        '?lat=${position.latitude}'
        '&lon=${position.longitude}'
        '&appid=$apiKey'
        '&units=metric'
        '&lang=vi',
      );

      final response = await http.get(url);

      print('STATUS: ${response.statusCode}');
      print('DATA: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          city = data['name'];
          temp = data['main']['temp'].toStringAsFixed(1);
          description = data['weather'][0]['description'];
          icon = data['weather'][0]['icon'];
          loading = false;
        });
      } else {
        final data = jsonDecode(response.body);

        setState(() {
          error = data['message'] ?? 'Không lấy được thời tiết';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Không lấy được vị trí: $e';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Mặc định lấy thời tiết Đà Nẵng
    getWeather('Da Nang');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clima'),
          centerTitle: true,

          actions: [
            IconButton(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // Ô tìm kiếm
              TextField(
                controller: cityController,

                decoration: InputDecoration(
                  hintText: 'Nhập thành phố',

                  border: const OutlineInputBorder(),

                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),

                    onPressed: () {
                      final cityName =
                          cityController.text.trim();

                      if (cityName.isNotEmpty) {
                        getWeather(cityName);
                      }
                    },
                  ),
                ),

                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    getWeather(value.trim());
                  }
                },
              ),

              const SizedBox(height: 40),

              // Loading
              if (loading)
                const CircularProgressIndicator()

              // Error
              else if (error.isNotEmpty)
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                )

              // Weather
              else ...[
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                if (icon.isNotEmpty)
                  Image.network(
                    'https://openweathermap.org/img/wn/'
                    '$icon@2x.png',
                    width: 100,
                  ),

                Text(
                  '$temp°C',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


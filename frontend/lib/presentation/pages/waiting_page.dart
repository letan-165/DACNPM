import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/api/network/api_client.dart';
import 'login_page.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  final ApiClient apiClient = ApiClient();
  Timer? timer;
  Color wifiColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _startPingLoop();
  }

  void _startPingLoop() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        wifiColor =
            wifiColor == Colors.white ? Colors.greenAccent : Colors.white;
      });

      // Ping server
      bool alive = await apiClient.ping();
      if (alive && mounted) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitPouringHourGlassRefined(color: Colors.white, size: 50),
            const SizedBox(height: 20),
            const SpinKitThreeBounce(color: Colors.white, size: 30),
            const SizedBox(height: 20),
            const Text(
              "Đang kết nối tới server...",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Icon(
              Icons.wifi,
              color: wifiColor,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

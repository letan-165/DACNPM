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
  bool connected = false;

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

      bool alive = await apiClient.ping();
      if (alive && mounted) {
        timer.cancel();
        setState(() {
          connected = true;
        });

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        });
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
            const SizedBox(height: 50),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 50),
            connected
                ? const Text(
                    "Đang chuyển trang....",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                : Column(
                    children: const [
                      SpinKitPouringHourGlassRefined(
                          color: Colors.white, size: 50),
                      SizedBox(height: 20),
                      SpinKitThreeBounce(color: Colors.white, size: 30),
                      SizedBox(height: 20),
                      Text(
                        "Đang kết nối tới server...",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            connected
                ? Container()
                : Icon(
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

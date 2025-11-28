import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_app/res/app_colors.dart';
import 'package:music_app/view/on_boarding/on_boarding.dart'; // Import the next screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait 1.5 seconds, then go to OnBoarding
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoarding()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Neumorphic Icon Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColor,
                boxShadow: [
                  BoxShadow(
                      color: shadowColor,
                      offset: const Offset(8, 6),
                      blurRadius: 12),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-8, -6),
                      blurRadius: 12),
                ],
              ),
              child: Icon(Icons.music_note_rounded,
                  size: 50, color: blueBackground),
            ),
            const SizedBox(height: 20),
            Text(
              'Music App',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blueBackground),
            )
          ],
        ),
      ),
    );
  }
}

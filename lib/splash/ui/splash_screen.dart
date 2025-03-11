import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_reminder/on_boarding_section/view/on_boarding_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.5; // Start small
  double _opacity = 0.0; // Start transparent

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _scale = 1.2; // Scale up
        _opacity = 1.0; // Fade in
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      Get.off(OnboardingScreen()); // Navigate to Home Screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8E8AA3),
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: _opacity,
          child: AnimatedScale(
            scale: _scale,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('asstes/splash_image/splash-removebg-preview.png', width: 210, height: 210),

                Text(
                  "Medi Guardian",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



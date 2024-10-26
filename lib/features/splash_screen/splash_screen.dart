import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:driver_app/features/export_features.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const screenName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/lotties/Animation - 1715219189976.json')
        ],
      ),
      splashIconSize: MediaQuery.of(context).size.height,
      backgroundColor: Colors.green.shade100,
      nextScreen: const AuthScreen(),
    );
  }
}

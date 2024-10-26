import 'package:driver_app/features/export_features.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = 'authScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  LoginScreen(),
                  RegisterScreen(),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const SwapEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.green,
                  type: SwapType.zRotation),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

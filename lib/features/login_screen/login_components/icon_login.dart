import 'package:flutter/material.dart';

class IconLogin extends StatelessWidget {
  const IconLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: 200,
          width: 200,
        )
      ],
    );
  }
}
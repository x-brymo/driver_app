import 'package:flutter/material.dart';

void showSnackbar(String message, BuildContext context, bool isSuccess) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Colors.white
      ),
    ),
    duration: const Duration(seconds: 4),
    backgroundColor: isSuccess == true ? Colors.green.shade600 : Colors.red.shade400,
    showCloseIcon: true,
    closeIconColor: Colors.white,
  );
  
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
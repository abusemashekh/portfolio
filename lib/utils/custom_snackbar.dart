import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void show({
    required String title,
    required String message,
    required bool isError,
  }) {
    final isMobile = Get.width < 600;
    final snackBarWidth = isMobile ? Get.width * 0.9 : Get.width * 0.3;
    final position = isMobile ? SnackPosition.BOTTOM : SnackPosition.TOP;

    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      snackPosition: position,
      margin: EdgeInsets.only(
        top: isMobile ? 0 : 20,
        bottom: isMobile ? 20 : 0,
        right: isMobile ? 20 : 30,
      ),
      borderRadius: 12,
      maxWidth: snackBarWidth,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}

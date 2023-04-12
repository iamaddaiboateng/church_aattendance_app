import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    duration: Duration(seconds: 5),
    colorText: Colors.white,
    backgroundColor: Colors.red.withOpacity(0.5),
  );
}

successSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    colorText: Colors.white,
    backgroundColor: Colors.teal.withOpacity(0.5),
  );
}

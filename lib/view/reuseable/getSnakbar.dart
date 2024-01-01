import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getSnackBar(String message ){

  Get.snackbar(
    'Error',
    message,
    // messageText: Text(
    //   message,
    //   style: TextStyle(fontSize: 30),
    // ),
    duration: Duration(seconds:15),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    borderRadius: 10,
    margin: EdgeInsets.all(10),
    isDismissible: false,

    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    mainButton: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'Close',
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
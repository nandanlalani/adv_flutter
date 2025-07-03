import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SnackbarGetxView extends StatelessWidget {
  const SnackbarGetxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SnackBar using Getx"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  "Snackbar",
                  "Flutter Snackbar using getX in stateless widget",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.cyanAccent,
                  duration: Duration(milliseconds: 1000),
                );
              },
              child: Text("SnackBar")),
        ),
      ),
    );
  }
}

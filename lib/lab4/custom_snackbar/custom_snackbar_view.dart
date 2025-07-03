import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomSnackbarView extends StatelessWidget {
  const CustomSnackbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SnackBar using Getx"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Container(
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      "Snackbar",
                      "Flutter Snackbar using getX in stateless widget",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.cyanAccent,
                      borderRadius: 5,
                      duration: Duration(milliseconds: 2000),
                    );
                  },
                  child: Text("SnackBar1")),

              ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      "Snackbar",
                      "Flutter Snackbar using getX in stateless widget",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      borderRadius: 0,
                      duration: Duration(milliseconds: 2000),
                    );
                  },
                  child: Text("SnackBar2")),

              ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      "Snackbar",
                      "Flutter Snackbar using getX in stateless widget",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.blue,
                      duration: Duration(milliseconds: 1000),
                    );
                  },
                  child: Text("SnackBar3")),

              ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      "Snackbar",
                      "Flutter Snackbar using getX in stateless widget",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      duration: Duration(milliseconds: 1000),
                    );
                  },
                  child: Text("SnackBar4")),
            ],
          ),
        ),
      ),
    );
  }
}

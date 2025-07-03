import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomDialogView extends StatelessWidget {
  const CustomDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Dialog Box"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Container(
            child: ElevatedButton(onPressed: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  title: Text("Custom Dialog"),
                  content: Text("Custom dialog box created using Get.dialog "),
                  actions: [
                    ElevatedButton(onPressed: () {
                      Get.back();
                    }, child: Text("Back"))
                  ],
                ),
                barrierDismissible: false,
              );
            }, child: Text("Custom Dialog"))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DialogView extends StatelessWidget {
  const DialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog using Getx"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(onPressed: () {
            Get.defaultDialog(
              title: "Alert Dialog Box(GetX)",
              textConfirm: "Yes",
              textCancel: "No",
              textCustom: "Hello",
              onCancel: () => Get.back(),
            );
          },  child: Text("Show Dialog")),
        ),
      ),
    );
  }
}

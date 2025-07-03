import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BottomSheetView extends StatelessWidget {
  const BottomSheetView({super.key});

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
            Get.bottomSheet(Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Data $index"),
                );
              },),
            ));
          },  child: Text("Bottom sheet")),
        ),
      ),
    );;
  }
}

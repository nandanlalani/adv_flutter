import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: Center(
        child: Container(
          child: ElevatedButton(onPressed: () {
            Get.to(Page2());
          }, child: Text("About Us")),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"),),
      body: Center(
        child: Container(
          child: ElevatedButton(onPressed: () {
            Get.back();
          }, child: Text("Home")),
        ),
      ),
    );
  }
}


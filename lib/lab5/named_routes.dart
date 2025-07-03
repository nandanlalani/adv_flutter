import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NamedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(P2(),
                    arguments: 'Hello from First Page!',
                    transition: Transition.rightToLeft);
              },
              child: Text("Go to Second Page"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Get.to(P2(),
                    arguments: 'Hello from First Page!',
                    transition: Transition.fadeIn);
              },
              child: Text("Go to Second Page"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Get.to(P2(),
                    arguments: 'Hello from First Page!',
                    transition: Transition.circularReveal);
              },
              child: Text("Go to Second Page"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Get.to(P2(),
                    arguments: 'Hello from First Page!');
              },
              child: Text("Go to Second Page"),
            ),
          ],
        ),
      ),
    );
  }
}

class P2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String data = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Container(
        decoration: BoxDecoration(color: Colors.cyan),
        child: Column(
          children: [
            Text(
              data,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

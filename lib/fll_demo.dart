import 'package:flutter/material.dart';

class Demo1 extends StatelessWidget {
  const Demo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Row(
                children: [
                  Expanded(child: Container(color: Colors.black,)),
                  Expanded(child: Container(color: Colors.white,)),
                  Expanded(child: Container(color: Colors.red,)),
                ],
              )),
          Expanded(
              child: Row(
                children: [
                  Expanded(child: Container(color: Colors.red,)),
                  Expanded(child: Container(color: Colors.blue,)),
                  Expanded(child: Container(color: Colors.yellow,)),
                ],
              )),
          Expanded(
              child: Row(
                children: [
                  Expanded(child: Container(color: Colors.green,)),
                  Expanded(child: Container(color: Colors.blue,)),
                  Expanded(child: Container(color: Colors.black,)),
                ],
              )),
        ],
      ),
    );
  }
}
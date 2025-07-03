import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'non_reactive_controller.dart';

class NonReactiveView extends StatelessWidget {
  NonReactiveView({super.key});
  final NonReactiveController nrc = Get.put(NonReactiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NonReactiveController>(
          builder: (_) => Center(
                  child: Text(
                "${nrc.counter}",
                style: TextStyle(fontSize: 40, color: Colors.blue.shade700),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nrc.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

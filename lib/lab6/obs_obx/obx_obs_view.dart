import 'package:flutter/material.dart';

import 'obx_obs_controller.dart';
import 'package:get/get.dart';

class ObxObsView extends StatelessWidget {
  ObxObsView({super.key});
  final ObxObsController obxObsController = Get.put(ObxObsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Obx(() => Text(
            "${obxObsController.userlist}",
            style: TextStyle(fontSize: 20, color: Colors.blue.shade500),
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          obxObsController.adduser();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

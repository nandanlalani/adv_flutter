import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_controller.dart';

class FlagView extends StatelessWidget {
  final controller = Get.put(FlagController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flags - CRUD')),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: controller.addOrUpdateFlag,
                    child: Text(controller.editingId == null ? 'Add' : 'Update'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.flags.length,
                itemBuilder: (context, index) {
                  final flag = controller.flags[index];
                  return ListTile(
                    title: Text(flag.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => controller.editFlag(flag),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteFlag(flag.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

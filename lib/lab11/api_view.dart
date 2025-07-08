import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_controller.dart';

class FlagView extends StatelessWidget {
  final controller = Get.put(FlagController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API List')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError.value) {
          return const Center(child: Text('Error loading data'));
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.onSearchChanged,
                  decoration: const InputDecoration(
                    labelText: 'Search Flags',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredFlags.length,
                  itemBuilder: (context, index) {
                    final flag = controller.filteredFlags[index];
                    return ListTile(
                      title: Text(flag.name),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

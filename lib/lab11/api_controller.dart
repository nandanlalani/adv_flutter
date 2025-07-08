import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_model.dart';
import 'api_helper.dart';

class FlagController extends GetxController {
  var flags = <FlagModel>[].obs;
  var isLoading = false.obs;
  final nameController = TextEditingController();
  String? editingId;

  @override
  void onInit() {
    fetchFlags();
    super.onInit();
  }

  void fetchFlags() async {
      final data = await ApiService.fetchFlags();
      flags.assignAll(data);
  }

  void addOrUpdateFlag() async {
    final name = nameController.text.trim();
      if (editingId == null) {
        final newFlag = FlagModel(id: '', name: name);
        final added = await ApiService.addFlag(newFlag);
        flags.add(added);
      } else {
        final updated = FlagModel(id: editingId!, name: name);
        await ApiService.updateFlag(editingId!, updated);
        int index = flags.indexWhere((f) => f.id == editingId);
        if (index != -1) flags[index] = updated;
        editingId = null;
      }
      nameController.clear();
  }

  void editFlag(FlagModel flag) {
    editingId = flag.id;
    nameController.text = flag.name;
  }

  void deleteFlag(String id) async {
      await ApiService.deleteFlag(id);
      flags.removeWhere((f) => f.id == id);
  }
}

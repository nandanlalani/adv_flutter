import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_model.dart';
import 'api_helper.dart';

class FlagController extends GetxController {
  var flags = <FlagModel>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var searchText = ''.obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    fetchFlags();
    super.onInit();
  }

  void fetchFlags() async {
    try {
      isLoading.value = true;
      isError.value = false;
      final data = await ApiService.fetchFlags();
      flags.assignAll(data);
    } catch (e) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  List<FlagModel> get filteredFlags {
    if (searchText.isEmpty) return flags;
    return flags.where((flag) => flag.name.toLowerCase().contains(searchText.value.toLowerCase())).toList();
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }
}

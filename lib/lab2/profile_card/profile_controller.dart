import 'package:adv_flutt/lab2/profile_card/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final cityController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final List<ProfileModel> profiles = [];

  void addProfile() {
    var newProfile = ProfileModel(
      name: nameController.text.trim(),
      age: int.parse(ageController.text.trim()),
      city: cityController.text.trim(),
    );
    profiles.add(newProfile);
    clearFields();
  }

  void clearFields() {
    nameController.clear();
    ageController.clear();
    cityController.clear();
  }

}

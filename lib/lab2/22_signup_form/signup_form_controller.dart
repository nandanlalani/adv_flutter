import 'package:flutter/material.dart';

class SignupController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool validateForm(BuildContext context) {
    if (!formKey.currentState!.validate()) return false;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return false;
    }

    return true;
  }

  void submitForm(BuildContext context) {
    if (validateForm(context)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup Successful')),
      );
      clear();
    }
  }

  void clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}

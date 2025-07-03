import 'package:adv_flutt/lab2/22_signup_form/signup_form_controller.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController _controller = SignupController();


  InputDecoration _inputDecoration(String label) {
    return InputDecoration(labelText: label, border: OutlineInputBorder());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _controller.nameController,
                  decoration: _inputDecoration("Name"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Name is required';
                    if (value.length < 3 || value.length > 50)
                      return 'Name must be 3-50 characters';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.emailController,
                  decoration: _inputDecoration("Email"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Email is required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) return 'Invalid email';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.phoneController,
                  decoration: _inputDecoration("Phone Number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty)
                      return 'Phone is required';
                    if (!RegExp(r'^\d{10}$').hasMatch(value))
                      return 'Enter valid 10-digit phone';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.passwordController,
                  decoration: _inputDecoration("Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Password required';
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _controller.confirmPasswordController,
                  decoration: _inputDecoration("Confirm Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Confirm your password';
                    return null; // password match check in controller
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _controller.submitForm(context),
                  child: Text("Signup"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

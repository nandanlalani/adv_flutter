import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'stu_model.dart';
import 'stu_controller.dart';

class StudentFormPage extends StatelessWidget {
  final Student? student;
  final StudentController controller = Get.find<StudentController>();

  final _formKey = GlobalKey<FormState>();

  StudentFormPage({super.key, this.student});


  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController enrollController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController cgpaController = TextEditingController();
  final TextEditingController priorCgpaController = TextEditingController();
  final RxBool isD2D = false.obs;

  @override
  Widget build(BuildContext context) {
    if (student != null) {
      nameController.text = student!.name;
      lastNameController.text = student!.lastName;
      enrollController.text = student!.enrollmentNo;
      emailController.text = student!.email;
      phoneController.text = student!.phoneNumber;
      branchController.text = student!.branch;
      cgpaController.text = student!.cgpa.toString();
      priorCgpaController.text = student!.priorEducationCgpa.toString();
      isD2D.value = student!.isD2D;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Container(
            width: 1000,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(nameController, 'First Name'),
                  _buildTextField(lastNameController, 'Last Name'),
                  _buildTextField(enrollController, 'Enrollment Number'),
                  _buildTextField(emailController, 'Email'),
                  _buildTextField(phoneController, 'Phone Number'),
                  _buildTextField(branchController, 'Branch'),
                  _buildTextField(cgpaController, 'CGPA', isNumber: true),
                  Obx(() => _buildTextField(
                    priorCgpaController,
                    isD2D.value ? 'Diploma CGPA' : '12th CGPA',
                    isNumber: true,
                  )),
                  Obx(() => SwitchListTile(
                    title: const Text('Is D2D Student?'),
                    value: isD2D.value,
                    onChanged: (val) => isD2D.value = val,
                  )),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newStudent = Student(
                          id: student?.id,
                          name: nameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          enrollmentNo: enrollController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          branch: branchController.text.trim(),
                          cgpa: double.tryParse(cgpaController.text) ?? 0.0,
                          priorEducationCgpa:
                          double.tryParse(priorCgpaController.text) ?? 0.0,
                          isD2D: isD2D.value,
                        );

                        if (student == null) {
                          controller.addStudent(newStudent);
                        } else {
                          controller.updateStudent(newStudent);
                        }

                        Get.back();
                      }
                    },
                    child: Text(student == null ? 'Add Student' : 'Update Student'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType:
        isNumber ? TextInputType.numberWithOptions(decimal: true) : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) =>
        value == null || value.trim().isEmpty ? 'Enter $label' : null,
      ),
    );
  }
}

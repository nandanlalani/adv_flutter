import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'stu_controller.dart';
import 'stu_form.dart';

class StudentListPage extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student List")),
      body: Obx(() {
        if (controller.studentList.isEmpty) {
          return Center(child: Text("No Students Found."));
        }
        return ListView.builder(
          itemCount: controller.studentList.length,
          itemBuilder: (context, index) {
            final student = controller.studentList[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text("${student.name} ${student.lastName}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enrollment: ${student.enrollmentNo}"),
                    Text("Email: ${student.email}"),
                    Text("Phone: ${student.phoneNumber}"),
                    Text("Branch: ${student.branch}"),
                    Text("CGPA: ${student.cgpa.toStringAsFixed(2)}"),
                    Text("${student.isD2D ? 'Diploma CGPA' : '12th CGPA'}: ${student.priorEducationCgpa.toStringAsFixed(2)}"),
                  ],
                ),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Get.to(() => StudentFormPage(student: student));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Delete?",
                          middleText: "Are you sure you want to delete this student?",
                          textConfirm: "Yes",
                          textCancel: "No",
                          confirmTextColor: Colors.white,
                          onConfirm: () {
                            controller.deleteStudent(student.id!);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => StudentFormPage());
        },
        child: Icon(Icons.add),
        tooltip: 'Add Student',
      ),
    );
  }
}

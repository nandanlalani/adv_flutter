import 'package:adv_flutt/utils/string.dart';

class Student {
  int? id;
  String name;
  String lastName;
  String enrollmentNo;
  String email;
  String phoneNumber;
  String branch;
  double cgpa;
  double priorEducationCgpa;
  bool isD2D;

  Student({
    this.id,
    required this.name,
    required this.lastName,
    required this.enrollmentNo,
    required this.email,
    required this.phoneNumber,
    required this.branch,
    required this.cgpa,
    required this.priorEducationCgpa,
    required this.isD2D,
  });

  factory Student.fromMap(Map<String, dynamic> json) => Student(
    id: json[STU_ID],
    name: json[STU_FNAME],
    lastName: json[STU_LASTNAME],
    enrollmentNo: json[STU_ENROLL],
    email: json[STU_EMAIL],
    phoneNumber: json[STU_PHONE_NUMBER],
    branch: json[STU_BRANCH],
    cgpa: json[STU_CGPA],
    priorEducationCgpa: json[STU_PRIOR],
    isD2D: json[STU_IS_D2D] == 1,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'lastName': lastName,
    'enrollmentNo': enrollmentNo,
    'email': email,
    'phoneNumber': phoneNumber,
    'branch': branch,
    'cgpa': cgpa,
    'priorEducationCgpa': priorEducationCgpa,
    'isD2D': isD2D ? 1 : 0,
  };
}

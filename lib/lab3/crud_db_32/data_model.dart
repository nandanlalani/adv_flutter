import 'package:adv_flutt/lab9/stu_model.dart';

class UserModel {
  int? uid;
  String name;
  String city;
  String gender;

  UserModel({this.uid, required this.name, required this.city, required this.gender});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'city': city,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      city: map['city'],
      gender: map['gender'],
    );
  }
}

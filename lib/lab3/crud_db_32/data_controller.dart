import 'package:adv_flutt/lab3/crud_db_32/data_db_helper.dart';

import 'data_model.dart';

class UserController {

  MyDatabase _db = MyDatabase();
  Future<List<UserModel>> fetchUsers() async {
    return await _db.getUsers();
  }

  Future<void> addUser(UserModel user) async {
    await _db.insertUser(user);
  }

  Future<void> updateUser(UserModel user) async {
    await _db.updateUser(user);
  }

  Future<void> deleteUser(int uid) async {
    await _db.deleteUser(uid);
  }
}

import 'package:adv_flutt/lab2/21_user_list_fav/user_list_model.dart';

class UserController{
  List<User> user = [
  User(name: 'abc'),
  User(name: 'bcd'),
  User(name: 'Nandan'),
  User(name: 'Raj'),
  ];


  void toggleFavorite(int index) {
  user[index].isFavourite = !user[index].isFavourite;
  }
}
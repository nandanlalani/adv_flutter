import 'package:adv_flutt/lab2/21_user_list_fav/user_list_controller.dart';
import 'package:flutter/material.dart';

class user_list_view extends StatefulWidget {
  user_list_view({super.key});

  @override
  State<user_list_view> createState() => _user_list_viewState();
}

class _user_list_viewState extends State<user_list_view> {
  UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List"),),

      body: ListView.builder(
        itemCount: _controller.user.length,
        itemBuilder:(context, index) {
          return ListTile(
            title: Text(_controller.user[index].name),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _controller.toggleFavorite(index);
                  });
                },
                icon: Icon(Icons.directions_bus),),

          );
        },),
    );
  }
}


// icon: Icon(
// _controller.user[index].isFavourite ? Icons.favorite : Icons.favorite_border,
// color: _controller.user[index].isFavourite ? Colors.red : null,
// ),),
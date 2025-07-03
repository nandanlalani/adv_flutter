import 'package:flutter/material.dart';
import 'data_model.dart';
import 'data_controller.dart';


class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserController _controller = UserController();

  List<UserModel> users = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String gender = 'Male';
  int? editingUserId;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final data = await _controller.fetchUsers();
    setState(() => users = data);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        uid: editingUserId,
        name: nameController.text,
        city: cityController.text,
        gender: gender,
      );

      if (editingUserId == null) {
        await _controller.addUser(user);
      } else {
        await _controller.updateUser(user);
        editingUserId = null;
      }

      nameController.clear();
      cityController.clear();
      gender = 'Male';
      _loadUsers();
    }
  }

  void _editUser(UserModel user) {
    setState(() {
      editingUserId = user.uid;
      nameController.text = user.name;
      cityController.text = user.city;
      gender = user.gender;
    });
  }

  void _deleteUser(int uid) async {
    await _controller.deleteUser(uid);
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User CRUD")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                validator: (val) => val!.isEmpty ? "Enter name" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City', border: OutlineInputBorder()),
                validator: (val) => val!.isEmpty ? "Enter city" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: gender,
                decoration: InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (newVal) => setState(() => gender = newVal!),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(editingUserId == null ? 'Add User' : 'Update User'),
              ),
            ]),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text("City: ${user.city} | Gender: ${user.gender}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: Icon(Icons.edit), onPressed: () => _editUser(user)),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => _deleteUser(user.uid!)),
                    ],
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}



import 'package:adv_flutt/lab2/profile_card/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = ProfileController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Card Creator"),backgroundColor: Colors.cyan,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller.nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      prefixIconColor: Colors.cyan,
                    ),
                    validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.ageController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      labelText: "Age",
                      border: OutlineInputBorder(),
                      prefixIconColor: Colors.cyan,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Required";
                      final age = int.tryParse(val);
                      if (age == null || age <= 0) return "Invalid age";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _controller.cityController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      labelText: 'City',
                      border: OutlineInputBorder(),
                      prefixIconColor: Colors.cyan,
                    ),
                    validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.formKey.currentState!.validate()) {
                        setState(() {
                          _controller.addProfile();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Profile added successfully!"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text("Add Profile"),
                  ),
                  Divider(thickness: 2, height: 30),
                ],
              ),
            ),

            if (_controller.profiles.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.people, color: Colors.cyan),
                    SizedBox(width: 8),
                    Text(
                      "Profiles (${_controller.profiles.length})",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),

            Expanded(
              child: _controller.profiles.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: 80, color: Colors.grey.shade400,),
                    SizedBox(height: 16),
                    Text("No profiles yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey.shade600,),),
                    SizedBox(height: 8),
                    Text("Create your first profile above!", style: TextStyle(fontSize: 14, color: Colors.grey.shade500,),),
                  ],
                ),
              )
                  : GridView.builder(
                itemCount: _controller.profiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final profile = _controller.profiles[index];
                  final colors = [Colors.blue, Colors.green, Colors.purple, Colors.orange, Colors.red, Colors.teal];
                  final profileColor = colors[profile.name.hashCode % colors.length];

                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            profileColor,
                            Colors.white,
                            profileColor,

                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Profile icon
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: profileColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),

                            Text(
                              profile.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 4),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cake, size: 14, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text(
                                  "${profile.age}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    profile.city,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

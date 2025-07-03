import 'package:adv_flutt/lab3/list_dynamic_31/dynamic_list_controller.dart';
import 'package:flutter/material.dart';

class dynamic_list_view extends StatefulWidget {
  const dynamic_list_view({super.key});

  @override
  State<dynamic_list_view> createState() => _dynamic_list_viewState();
}

class _dynamic_list_viewState extends State<dynamic_list_view> {
  DynamicListController _controller = DynamicListController();
  TextEditingController _name = TextEditingController();
  int? editIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: Column(
        children: [
          //insert data
          TextFormField(
            controller: _name,
            decoration: InputDecoration(
              hintText: "Name",
              
              
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if(editIndex == null) {
                    _controller.addStudent(_name.text);
                  }
                  else{
                    _controller.updateStudent(editIndex!, _name.text);
                  }
                  _name.clear();
                  editIndex = null;
                });
              },
              child: (editIndex == null)?Text("Add"):Text("Edit")),

          SizedBox(
            height: 50,
          ),
          //list view
          Expanded(
            child: (_controller.students.length != 0)
                ? ListView.builder(
                    itemCount: _controller.students.length,
                    itemBuilder: (context, index) {
                      dynamic data = _controller.students[index];
                      return ListTile(
                        title: Text(data.name.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () {
                              setState(() {
                                _controller.deleteStudent(index);
                              });
                            }, icon: Icon(Icons.delete)),
                            IconButton(onPressed: () {
                              setState(() {
                                _name.text = data.name;
                                editIndex = index;
                              });
                            }, icon: Icon(Icons.edit))
                          ],
                        ),
                      );
                    })
                : Container(
                    child: Text("No data Available"),
                  ),
          ),
        ],
      ),
    );
  }
}




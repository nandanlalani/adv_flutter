import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _dataController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("First Page")),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            children: [
              TextField(
                controller: _dataController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(SecondPage(), arguments: _dataController.text);
                },
                child: Text("Go to Second Page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String receivedMessage = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: Column(
          children: [
            Text(
              receivedMessage,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () => FirstPage(), child: Text("Back")),
          ],
        ),
      ),
    );
  }
}

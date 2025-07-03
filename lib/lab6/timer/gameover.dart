import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThankyouPage extends StatelessWidget {
  ThankyouPage({super.key});
  // ShowHideContentController shc = ShowHideContentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Thank You!',style: TextStyle(color: Colors.red[700],fontSize: 100),),
            ElevatedButton(onPressed: (){
              Get.back();
            }, child: Text('Hide'))
          ],
        ),
      ),
    );
  }
}
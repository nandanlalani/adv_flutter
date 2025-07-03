import 'package:adv_flutt/lab6/showhide/show_hide_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../timer/gameover.dart';

class ShowHideView extends StatelessWidget {
  ShowHideView({super.key});
  ShowHideContentController shc = ShowHideContentController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Show Hide Content', style: TextStyle(fontSize: 30, color: Colors.pink.shade500))),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          shc.showContent();
          Get.to(ThankyouPage());
        }, child: Text(!shc.toShow.value?'Show':'Hide')),
      ) ,
    );
  }
}
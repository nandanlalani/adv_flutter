import 'dart:async';
import 'package:get/get.dart';
import 'gameover.dart';


class TimerCountdownController extends GetxController{
  RxInt time = 0.obs;
  Timer ? timer;

  void startTime(){
    timer = Timer.periodic(Duration(seconds: 1),(timer) {
      if (time >= 0) {
        time++;
        if(time==10){
          timer.cancel();
          Get.to(ThankyouPage());
        }

      }
    } );
  }

}
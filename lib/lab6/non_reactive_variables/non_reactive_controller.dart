
import 'package:get/get.dart';

class NonReactiveController extends GetxController{
  int counter = 0;

  void increment(){
    counter++;
    print("Counter $counter");
    update();
  }
}
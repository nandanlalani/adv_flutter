import 'package:get/get.dart';

class ObxObsController extends GetxController{
  RxList<dynamic> userlist = [].obs;

  void adduser(){
    userlist.add("Nandan");
    update();
  }
}
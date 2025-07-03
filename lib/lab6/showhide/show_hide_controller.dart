import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowHideContentController extends GetxController{
  RxBool toShow = false.obs;
  bool isDark = false;
  ThemeMode get theme => isDark? ThemeMode.dark:ThemeMode.light;

  void showContent(){
    toShow.value = !toShow.value;
  }

}
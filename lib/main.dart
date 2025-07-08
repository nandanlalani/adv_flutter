import 'package:adv_flutt/Demo.dart';
import 'package:adv_flutt/fll_demo.dart';
import 'package:adv_flutt/lab11/api_view.dart';
import 'package:adv_flutt/lab4/bottom_sheet_getx/bottom_sheet_view.dart';
import 'package:adv_flutt/lab4/custom_bottom_sheet/custom_bottom_sheet_view.dart';
import 'package:adv_flutt/lab4/custom_dialog/custom_dialog_view.dart';
import 'package:adv_flutt/lab4/dialog_alert_butons/dialog_view.dart';
import 'package:adv_flutt/lab4/snackbar_getx/snackbar_getx_view.dart';
import 'package:adv_flutt/lab5/data_page.dart';
import 'package:adv_flutt/lab5/named_routes.dart';
import 'package:adv_flutt/lab5/page1.dart';
import 'package:adv_flutt/lab6/non_reactive_variables/non_reactive_view.dart';
import 'package:adv_flutt/lab6/obs_obx/obx_obs_view.dart';
import 'package:adv_flutt/lab6/showhide/show_hide_view.dart';
import 'package:adv_flutt/lab6/timer/timer_counter_view.dart';
import 'package:adv_flutt/lab9/stu_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lab10/crud_db_view.dart';
import 'lab2/21_user_list_fav/user_list_view.dart';
import 'lab2/22_signup_form/signup_form_view.dart';
import 'lab2/e-commerce/ecommerce_view.dart';
import 'lab3/crud_db_32/data_view.dart';
import 'lab4/custom_snackbar/custom_snackbar_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => NamedRoutes()),
        GetPage(
          name: '/second', page: () => P2(),
          transition: Transition.leftToRight,
          transitionDuration: Duration(milliseconds: 600),
        ),
      ],
      home: StudentView(),
    );
  }
}

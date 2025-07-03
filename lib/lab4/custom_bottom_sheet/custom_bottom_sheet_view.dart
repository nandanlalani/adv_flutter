import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomBottomSheetView extends StatelessWidget {
  const CustomBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog using Getx"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(onPressed: () {
                  Get.bottomSheet(Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                    ),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Data $index"),
                        );
                      },),
                  ));
                },  child: Text("Bottom sheet1")),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                  Get.bottomSheet(
                      Container(
                        height: 1000,
                        width: 2000,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                    ),
                    child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Data $index"),
                        );
                      },),
                  ));
                },  child: Text("Bottom sheet2")),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_meds/models/activity.dart';

import '../models/medicine.dart';

class NotificationDetails extends StatelessWidget {
  final Medicine? medicine;
  final Activity? activity;
  const NotificationDetails({super.key, this.medicine, this.activity});

  @override
  Widget build(BuildContext context) {
    String title;
    String note;
    String done, skip;
    String appBarTitle;
    if (medicine != null) {
      title = medicine!.title as String;
      note = medicine!.note as String;
      done = 'Took it';
      skip = "Skipped";
      appBarTitle = 'Take Medicine';
    } else {
      title = activity!.title as String;
      note = activity!.note as String;
      done = 'Done';
      skip = 'Skip';
      appBarTitle = 'Perform Activity';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              title,

          ),
          Text(
            note
          ),
          Row(
            
            children: [
              Expanded(child: ElevatedButton(
                
                onPressed: (){
                Get.back();
              }, child: Text(skip))),
              Expanded(child: ElevatedButton(onPressed: (){
                
              }, child: Text(done)))
            ],
          )
        ],
      ),
    );
  }
}

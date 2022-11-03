import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_meds/models/activity.dart';
import 'package:my_meds/utilities/medicine_controller.dart';

import '../models/medicine.dart';
import '../utilities/db_helper.dart';

class NotificationDetails extends StatelessWidget {
  final String title;
  final String note;
  final int id;

  const NotificationDetails(
      {super.key, required this.title, required this.note, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Item'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
          ),
          Text(note),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Skip'))),
              Expanded(
                  child: ElevatedButton(onPressed: () {
                    DBHelper.reduceDose(id);
                    Get.back();
                  }, child: const Text("Done")))
            ],
          )
        ],
      ),
    );
  }
}

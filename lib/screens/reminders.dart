// This is the screen to list all the stored medications and activities

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:my_meds/screens/form.dart';
import 'package:my_meds/utilities/medicine_controller.dart';
import 'package:tab_container/tab_container.dart';

import '../widgets/reminder_tile.dart';

class Reminder extends StatelessWidget {
  Reminder({Key? key}) : super(key: key);

  final _itemController = Get.put(ItemController());

  final tabStyle = const TextStyle(
    fontSize: 25,
    // backgroundColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    _itemController.getMedicines();
    _itemController.getActivities();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
        body : HawkFabMenu(
          fabColor: Colors.indigo,
          items: [
            HawkFabMenuItem(label: 'Add Medicine', ontap: (){
              _goToForm(isForMedicine: true);
            }, icon: const Icon(Icons.medication)),
            HawkFabMenuItem(label: 'Add Activity', ontap: () {
              _goToForm(isForMedicine: false);
            }, icon: const Icon(Icons.directions_run))
          ],
          body: TabContainer(
            radius: 0,
            color: Get.isDarkMode ? Colors.black : Colors.white,
            isStringTabs: false,
            tabs: [
              Text('Medicines',
                style: tabStyle,),
              Text('Activities',
                style: tabStyle,),
            ],
            children: [
              _showMedicines(),
              _showActivities(),
            ],
          ),
        )
    );
  }

  _showMedicines() {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
                itemCount: _itemController.medicineList.length,
                itemBuilder: (_, index) {
                  var currentMedicine = _itemController.medicineList[index];
                  return ReminderTile(
                    id: currentMedicine.id as int,
                    title: currentMedicine.title as String,
                    note: currentMedicine.note as String,
                    date: currentMedicine.note as String,
                    type: currentMedicine.type as int,
                    meal: currentMedicine.meal,
                    sequence: currentMedicine.sequence,
                    dose: currentMedicine.dose,
                  );
                });
          }),
        ),
    ]
    );
  }

  _showActivities() {
    return Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                  itemCount: _itemController.activityList.length,
                  itemBuilder: (_, index) {
                    var currentActivity = _itemController.activityList[index];
                    return ReminderTile(
                      id: currentActivity.id as int,
                      title: currentActivity.title as String,
                      note: currentActivity.note as String,
                      date: currentActivity.date as String,
                      type: currentActivity.type as int,
                      time: currentActivity.time,
                    );
                  });
            }),
          ),
        ]
    );
  }

  void _goToForm({required bool isForMedicine}) async {
    await Get.to(() => AddItem(isForMedicine: isForMedicine,));
    _itemController.getMedicines();
    _itemController.getActivities();
  }
}

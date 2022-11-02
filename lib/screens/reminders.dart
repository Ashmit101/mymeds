// This is the screen to list all the stored medications and activities

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:tab_container/tab_container.dart';

class Reminder extends StatelessWidget {
  const Reminder({Key? key}) : super(key: key);

  final tabStyle = const TextStyle(
    fontSize: 25,
    // backgroundColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
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
    return const Center(
      child: Text('To be added'),
    );
    // return Column(
    //   children: [
    //     Expanded(
    //       child: Obx(() {
    //         return ListView.builder(
    //             itemCount: _medicineController.medicineList.length,
    //             itemBuilder: (_, index) {
    //               var currentMedicine = _medicineController.medicineList[index];
    //               return ReminderTile(
    //                 title: currentMedicine.title as String,
    //                 note: currentMedicine.note as String,
    //                 date: currentMedicine.note as String,
    //                 time: currentMedicine.time as String,
    //               );
    //             });
    //       }),
    //     ),
  }

  _showActivities() {
    return const Center(
        child: Text("Activities")
    );
  }

  void _goToForm({required bool isForMedicine}) {
  }
}

import 'package:get/get.dart';
import 'package:my_meds/models/activity.dart';
import 'package:my_meds/utilities/db_helper.dart';

import 'package:my_meds/models/medicine.dart';

class ItemController extends GetxController {

  var medicineList = <Medicine>[].obs;
  var activityList = <Activity>[].obs;

  Future<int?> addMedicine({Medicine? medicine}) async {
    return await DBHelper.insertMedicine(medicine);
  }

  void getMedicines() async {
    var  medicines = await  DBHelper.readAllMedicines();
    print('getMedicines() : ${medicines.runtimeType}');
    medicineList.assignAll(medicines.map((data) => Medicine.fromJson(data)).toList());
  }

  Future<int?> addActivity({required Activity activity}) async {
    return await DBHelper.insertActivity(activity);
  }

  void getActivities() async {
    var  activities = await  DBHelper.readAllActivities();
    print('getActivities() : ${activities.runtimeType}');
    activityList.assignAll(activities.map((data) => Activity.fromJson(data)).toList());
  }
}

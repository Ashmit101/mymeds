import 'package:get/get.dart';
import 'package:my_meds/utilities/db_helper.dart';

import 'package:my_meds/models/medicine.dart';

class MedicineController extends GetxController {

  var medicineList = <Medicine>[].obs;

  Future<int?> addMedicine({Medicine? medicine}) async {
    return await DBHelper.insertMedicine(medicine);
  }

  void getMedicines() async {
    var  medicines = await  DBHelper.readAllMedicines();
    print('getMedicines() : ${medicines.runtimeType}');
    medicineList.assignAll(medicines.map((data) => Medicine.fromJson(data)).toList());
  }
}

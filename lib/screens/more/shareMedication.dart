import 'package:share_plus/share_plus.dart';

  void shareMed(String medicationList)async{
    ShareResult result;
    result = await Share.shareWithResult(medicationList, subject: 'List of current Medications');
  // return result.status.toString();
}


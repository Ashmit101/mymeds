import 'package:flutter/material.dart';
import 'package:my_meds/screens/more/contactSMS.dart';
import 'package:get/get.dart';
import 'package:my_meds/screens/more/search.dart';
import 'package:my_meds/screens/more/shareMedication.dart';
import 'package:share_plus/share_plus.dart';

class More extends StatelessWidget {
  const More({super.key});
  final String dummy = 'Medication list';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.contact_phone),),
          title:  const Text('Call and SMS'),
          subtitle:  const Text('Emergency call and SMS'),
          onTap: () {
            Get.to(ImportContact());
          },
        ),
        ListTile(
          
          leading: const CircleAvatar(child: Icon(Icons.share)),
          title: const Text('Share Medication'),
          subtitle: const Text('Share your medication details'),
          onTap: () {                
            String medicationList = "Test";
            shareMed(medicationList);
          },
    ),
            ListTile(
          
          leading: const CircleAvatar(child: Icon(Icons.search)),
          title: const Text('Search Medicine'),
          subtitle: const Text('Find more information about the medicine'),
          onTap: () {                
            Get.to(WebSearch());
          },
    ),
        ],
      );
  }
}


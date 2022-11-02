import 'package:flutter/material.dart';
import 'package:my_meds/screens/more/contactSMS.dart';



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
            Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => const ImportContact()),
            );
          },
        ),

      ],
    );
  }
}


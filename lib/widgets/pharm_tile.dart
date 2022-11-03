import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_meds/screens/pharmContact/pharm_map.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';



import '../utilities/geoapify_api_caller.dart';
import '../screens/pharmContact/prescription_cam.dart';

import '../screens/form.dart';

class PharmTileData extends StatelessWidget {
  final NearbyPharmaData pharmaData;
  const PharmTileData({super.key, required this.pharmaData});

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    return GestureDetector(
      onPanUpdate: (details) {
        swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
      },
      onPanEnd: (details) {
        if (swipeDirection == null) return;

        if (swipeDirection == 'left') {
          launchUrl(Uri.parse('tel://${pharmaData.phoneNo}'));
        }

        if (swipeDirection == 'right') {
          Get.to(PrescriptionCam());
        }
      },
      onDoubleTap: (() {
        Get.to(PharmMap());
      }),
      onTap: (() {}),
      child: Column(
        children: [
          ListTile(
            title: Text(pharmaData.name),
            trailing: Text(pharmaData.phoneNo),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

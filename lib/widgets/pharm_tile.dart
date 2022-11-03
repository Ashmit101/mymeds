import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/pharmContact/pharm_map.dart';
import '../utilities/geoapify_api_caller.dart';
import '../screens/pharmContact/prescription_cam.dart';

// import '../screens/form.dart';

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
          if (pharmaData.phoneNo != 'n/a') {
            if (pharmaData.phoneNo.contains(';')) {
              launchUrl(Uri.parse('tel://${pharmaData.phoneNo.substring(0, pharmaData.phoneNo.indexOf(';'))}'));
            } else {
              launchUrl(Uri.parse('tel://${pharmaData.phoneNo}'));
            }
          }
        }

        if (swipeDirection == 'right') {
          Get.to(PrescriptionCam(pharmaData: pharmaData,));
        }
      },
      onDoubleTap: (() {
        Get.to(PharmMap(pharmaData: pharmaData,));
      }),
      onLongPress: (() {

      }),
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

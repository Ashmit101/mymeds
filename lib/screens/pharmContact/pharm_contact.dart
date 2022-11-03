import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_meds/widgets/pharm_tile.dart';

import '../../utilities/geoapify_api_caller.dart';
import '../../utilities/current_location.dart';



class PharmContactScreen extends StatefulWidget {
  const PharmContactScreen({super.key});

  @override
  State<PharmContactScreen> createState() => _PharmContactScreenState();
}

class _PharmContactScreenState extends State<PharmContactScreen> {
  List<NearbyPharmaData> _nearbyPharmaData = [];

  Future getPharmaData() async {
    LocationData? locationData = await getLocationData();
    if (locationData != null) {
      List<NearbyPharmaData> pharmaData = await retrievePharmaData((locationData.longitude)!, (locationData.latitude)!, 20);
      setState(() {
        _nearbyPharmaData = pharmaData;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    getPharmaData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('PharmaData Lol'),
      ),
      body: SingleChildScrollView(
       child : Builder(
        builder: (context) {
          List<PharmTileData> texts = [];
          for (var dat in _nearbyPharmaData) {
            texts.add(PharmTileData(
                pharmaData: dat,
            ));
          }

          return Column(
            children: texts,
          );
        },
      )
      ),
    );
  }
}
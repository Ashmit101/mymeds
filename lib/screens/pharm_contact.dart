import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../utilities/geoapify_api_caller.dart';
import '../utilities/current_location.dart';

class PharmContactScreen extends StatefulWidget {
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
      body: Builder(
        builder: (context) {
          List<Text> texts = [];
          for (var dat in _nearbyPharmaData) {
            texts.add(Text(dat.name));
          }

          return Column(
            children: texts,
          );
        },
      ),
    );
  }
}
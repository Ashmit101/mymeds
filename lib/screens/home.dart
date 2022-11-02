// Local Import
import '../utilities/current_location.dart';

// Library Import
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  LocationData? _locationData;

  void getCurrentLocation() async {
    LocationData? locationData = await getLocationData();
    setState(() {
      _locationData = locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    if (_locationData == null) {
      return const Center(
        child: Text('Loading Current Location Data'),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const Text('...\n\n'),
            Text('Latitude: ${_locationData?.latitude}'),
            Text('Longitude: ${_locationData?.longitude}')
          ],
        ),
      );
    }
  }
}
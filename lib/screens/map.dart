import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import '../utilities/current_location.dart';
import '../utilities/geoapify_api_caller.dart';

class PharmaciesMap extends StatefulWidget {
  const PharmaciesMap({super.key});

  @override
  State<PharmaciesMap> createState() => _PharmaciesMapState();
}

class _PharmaciesMapState extends State<PharmaciesMap> {
  LocationData? _locationData;

  final List<Marker> _markers = []; // List of locations .. first value is current location of user, other values are the locations of the pharmacies and hospitals

  void getCurrentLocation() async {
    LocationData? locationData = await getLocationData();
    setState(() {
      _locationData = locationData;
      if (_markers.isEmpty && _locationData != null) {
        _markers.add(
          Marker(
              point: LatLng(
                  (_locationData?.latitude)!, (_locationData?.longitude)!
              ),
              builder: (BuildContext context) {
                return const Icon(Icons.accessibility, color: Colors.black,);
              }
          ),
        );
      } else if (_locationData != null) {
        _markers.first = Marker(
            point: LatLng(
                (_locationData?.latitude)!, (_locationData?.longitude)!
            ),
            builder: (BuildContext context) {
              return const Icon(Icons.accessibility, color: Colors.black,);
            }
        );
      }
    });
  }

  void addPharmaData() async {
    final parsedPharmadata = await retrievePharmaData((_locationData?.latitude)!, (_locationData?.longitude)!, 50);
    for (var data in parsedPharmadata) {
      print('${data.name} : ${data.phoneNo}');
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    //TODO: Add Widget to show parsed hospitals and pharmacies
    if (_locationData != null) {
      addPharmaData();
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: AppBar(
            title: const Text('Pharmacies Near Me'),
          ),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(
                (_locationData?.latitude)!, (_locationData?.longitude)!),
            minZoom: 1,
            maxZoom: 25,
            zoom: 15,
            slideOnBoundaries: true,
            screenSize: MediaQuery
                .of(context)
                .size,
          ),
          children: [
            TileLayer(
              urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayer(
              markers: _markers,
            )
          ],
        ),
      );
    } else {
      return const Center(
          child: Text('loading map...')
      );
    }
  }
}


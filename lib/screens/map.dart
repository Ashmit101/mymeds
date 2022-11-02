import 'dart:async';

import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../utilities/current_location.dart';
import '../utilities/geoapify_api_caller.dart';
// import '../widgets/pharma_location.dart';



class PharmaciesMap extends StatefulWidget {
  const PharmaciesMap({super.key});

  @override
  State<PharmaciesMap> createState() => _PharmaciesMapState();
}

class _PharmaciesMapState extends State<PharmaciesMap> {
  LocationData? _locationData;

  Map<String,Marker> _markers = {}; // List of locations .. first value is current location of user, other values are the locations of the pharmacies and hospitals

  // Future<Map<String,Marker>> _futuremarkers;
  bool pharmaDataAdded = false;
  bool pp = false;
  List<NearbyPharmaData> _parsedPharmaData = [];

  // List<Marker> _markerList = [];
  // final List<NearbyPharmaData> _addedPharmaData = []; // List of pharmacy and hospital data already rendered so that they aren't rendered many times

  Future getCurrentLocation() async {
    LocationData? locationData = await getLocationData();
    if (mounted) {
      setState(() {
        _locationData = locationData;
        
        // if (_locationData != null) {
        //   // _markers['home'] = Marker(
        //   //     point: LatLng(
        //   //         (_locationData?.latitude)!, (_locationData?.longitude)!
        //   //     ),
        //   //     builder: (BuildContext context) {
        //   //       print('builder of home');
        //   //       return const Icon(Icons.accessibility, color: Colors.black,);
        //   //     }
        //   // );
        // }


      });
    }
  }

  Future getPharmaData() async {
    final parsedPharmadata  =  await retrievePharmaData((_locationData?.latitude)!, (_locationData?.longitude)!, 20);
    // for (var data in parsedPharmadata) {
    //   if (!_markers.containsKey(data.name)) {
        if(mounted) {
          setState(() {
            _parsedPharmaData = parsedPharmadata;
            pharmaDataAdded = true;
            // _markers[data.name] = createMarker(data);
          });
      //   }
      // }
    }


  }

  List<Marker> mapToList (Map<String, Marker> map) {
    List<Marker> list = [];
    map.forEach((key, value) {list.add(value);});
    return list;
  }



  Builder buildFromMarker(NearbyPharmaData pharmadata, BuildContext context) {
    return Builder(
        builder: (context) {
          print('Displaying at ${pharmadata.latitude}, ${pharmadata.longitude}');
          return  const Icon(Icons.local_hospital, color: Colors.blue,);
        }
    );
  }

  Marker createMarker(NearbyPharmaData pharmadata) {
    print('creating marker for ${pharmadata.name}');
    return Marker(
        point: LatLng(
            pharmadata.latitude, pharmadata.longitude
        ),
        builder:  (BuildContext context) {
          print('Displaying at ${pharmadata.latitude}, ${pharmadata.longitude}');
          return  const Icon(Icons.local_hospital, color: Colors.blue,);
        }
    );
  }



  @override
  void initState() {


    // TODO: implement initState
    super.initState();
    // _futuremarkers = await updateData();
  }

  Future<Map<String, Marker>> updateData() async {
    Map<String, Marker> markerMap = {};
    getCurrentLocation();
    if (_locationData != null) {
      markerMap['home'] = Marker(
          point: LatLng(
            (_locationData?.latitude)!, (_locationData?.longitude)!
          ),
          builder: (BuildContext context) {
            print('builder of home');
            return const Icon(Icons.accessibility, color: Colors.black,);
          }
      );

      if (!pharmaDataAdded) {
        getPharmaData();
      } else {
        for (var data in _parsedPharmaData) {
          markerMap[data.name] = createMarker(data);
        }
      }

    }
    return markerMap;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    //TODO: Add Widget to show parsed hospitals and pharmacies
    if (_locationData != null) {
      return FutureBuilder<Map<String, Marker>>(
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, Marker>> snapshot,) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              setState(() {
                pp = true;
                _markers = snapshot.data!;
              });
              break;
            default:
          }

          if (pp) {
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
                        (_locationData?.latitude)!, (_locationData?.longitude)!
                    ),
                    minZoom: 1,
                    maxZoom: 25,
                    zoom: 15,
                    slideOnBoundaries: true,
                    screenSize: MediaQuery
                        .of(context)
                        .size,
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerClusterLayerWidget(options:
                    MarkerClusterLayerOptions(
                      maxClusterRadius: 120,
                      size: const Size(40, 40),
                      fitBoundsOptions: const FitBoundsOptions(
                        padding: EdgeInsets.all(50),
                      ),
                      markers: mapToList(_markers),
                      polygonOptions: const PolygonOptions(
                          borderColor: Colors.blueAccent,
                          color: Colors.black12,
                          borderStrokeWidth: 3),
                      builder: (context, markers) {
                        return FloatingActionButton(
                          onPressed: null,
                          child: Text(markers.length.toString()),
                        );
                      },
                    ),
                    ),

                  ],
                ),
              );

          } else {
            return const Center(child: Text('couldnt load lol'));
          }
        },
        future: updateData(),
      );
    // }
      // addPharmaData();
      // if (pharmaDataAdded) {
      //   _markers.forEach((key, value) {
      //     print('$key, ${value.point}');
      //   });
      //   return Scaffold(
      //     appBar: PreferredSize(
      //       preferredSize: const Size.fromHeight(20.0),
      //       child: AppBar(
      //         title: const Text('Pharmacies Near Me'),
      //       ),
      //     ),
      //     body: FlutterMap (
      //       options: MapOptions(
      //         center: LatLng(
      //             (_locationData?.latitude)!, (_locationData?.longitude)!
      //         ),
      //         minZoom: 1,
      //         maxZoom: 25,
      //         zoom: 15,
      //         slideOnBoundaries: true,
      //         screenSize: MediaQuery
      //             .of(context)
      //             .size,
      //       ),
      //       children: <Widget>[
      //         TileLayer(
      //           urlTemplate:
      //           'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      //           userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      //         ),
      //         MarkerClusterLayerWidget(options:
      //         MarkerClusterLayerOptions(
      //           maxClusterRadius: 120,
      //           size: const Size(40, 40),
      //           fitBoundsOptions: const FitBoundsOptions(
      //             padding: EdgeInsets.all(50),
      //           ),
      //           markers: mapToList(_markers),
      //           polygonOptions: const PolygonOptions(
      //               borderColor: Colors.blueAccent,
      //               color: Colors.black12,
      //               borderStrokeWidth: 3),
      //           builder: (context, markers) {
      //             return FloatingActionButton(
      //               onPressed: null,
      //               child: Text(markers.length.toString()),
      //             );
      //           },
      //         ),
      //         ),
      //
      //       ],
            // options: MapOptions(
            //   center: LatLng(
            //       (_locationData?.latitude)!, (_locationData?.longitude)!),
            //   minZoom: 1,
            //   maxZoom: 25,
            //   zoom: 15,
            //   slideOnBoundaries: true,
            //   screenSize: MediaQuery
            //       .of(context)
            //       .size,
            // ),
            // children: [
            //   TileLayer(
            //     urlTemplate:
            //     'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            //     userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            //   ),
            //   MarkerLayer(
            //     markers: _markerList,
            //   )
            // ],
          // ),
        // );
      } else {
        return const Center(
            child: Text('loading data...')
        );
      }
    // } else {
    //   return const Center(
    //       child: Text('loading map...')
    //   );
    // }
  }
}


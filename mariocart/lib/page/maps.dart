import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  Location location = new Location();
  LocationData _currentPosition;
  PermissionStatus _permissionGranted;
  GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    location.onLocationChanged.listen((LocationData l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Office Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
            onCameraMove: (position) {
        print(position);
        _initialcameraposition = LatLng(position.target.latitude, position.target.longitude);
      },
          initialCameraPosition: CameraPosition(
            target: LatLng(0.5937, 0.9629),
            zoom: 8,
          ),
           markers: Set<Marker>.of(markers.values)
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('go to lacation'),
          onPressed: () {

             _add();


            location.onLocationChanged.listen(
              (LocationData l) {
                _controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(l.latitude, l.longitude), zoom: 20.0),
                  ),
                );
              },
            );
          },
        ),

      ),
    );
  }
    void _add() {
    // ...
var markerIdVal = Random();
    final MarkerId markerId = MarkerId(markerIdVal.toString());
    final Marker marker = Marker(
      markerId: markerId,
      position: _initialcameraposition,
      infoWindow: InfoWindow(title: 'MY LOCATION', snippet: 'this is my LOCATION'),
      onTap: () {
        // ...
      },
      onDragEnd: (LatLng position) {
        //...
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }
}



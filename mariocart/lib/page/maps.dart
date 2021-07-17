import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
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
  final ref = FirebaseDatabase.instance.reference();
  var retrieve;
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
            ref.child('position').set({
              "lat":_initialcameraposition.latitude,
              "long":_initialcameraposition.longitude
              });
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
        //
        // ...
        showPositionOnFirebase();
       
      },
      onDragEnd: (LatLng position) {
       //...
        
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }
  showPositionOnFirebase(){

     ref.child("position").once().then((DataSnapshot data){
                  print(data.value);
                  print(data.key);
                  setState(() {
                    retrieve = data.value;
                  });
                });
                print(retrieve);

                showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Essa e sua posicao"),
          content: new Text("esta e a latitude $retrieve['lat'],esta e a longitude $retrieve['long']"??"ainda nao foi gravado"),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );



  }
}



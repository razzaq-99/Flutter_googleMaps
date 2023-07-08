import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  final Completer<GoogleMap> _controller = Completer();

  static const CameraPosition _position =
      CameraPosition(target: LatLng(25.4304, 68.2809), zoom: 14);

  final List<Marker> _markers = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(25.4304, 68.2809),
      infoWindow: InfoWindow(
        title: "My current location",
      ),
    )
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error" + error.toString());
    });

    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _position,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller as FutureOr<GoogleMap>?);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print("My current location is : ");
            print(value.latitude.toString() + " " + value.longitude.toString());

            _markers.add(
              const Marker(
                  markerId: MarkerId('2'),
                  // position: LatLng(value.latitude,value.longitude),
                  infoWindow: InfoWindow(
                    title: "My currennt location",
                  )),
            );
            CameraPosition camera = const CameraPosition(
              zoom: 14,
              target: LatLng(25.3960, 68.3578),
            );

            final GoogleMapController cont =
                (await _controller.future) as GoogleMapController;

            cont.animateCamera(CameraUpdate.newCameraPosition(camera));
            setState(() {

            });
          }
             );
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}

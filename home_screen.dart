import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMap> _controller = Completer();

  static const CameraPosition _position = CameraPosition(
      target: LatLng(25.4304, 68.2809), zoom: 14);

  final List<Marker> _markers = [];
  List<Marker> list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(25.4304, 68.2809),
       infoWindow: InfoWindow(
         title: "My current location",
       )
    ),

    Marker(
        markerId: MarkerId('2'),
        position: LatLng(25.3960, 68.3578),
        infoWindow: InfoWindow(
          title: "Hyderabad",
        )
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(27.0238, 74.2179),
        infoWindow: InfoWindow(
          title: "Rajasthan India",
        )
    ),


  ];

  @override
  void initState() {
    super.initState();
    _markers.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _position,
          markers: Set<Marker>.of(_markers),
          // myLocationEnabled: true,
          // compassEnabled: true,
          // mapType: MapType.normal,
          // myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller as FutureOr<GoogleMap>?);
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_disabled_outlined),
        onPressed: () async{
         GoogleMapController control = (await _controller.future) as GoogleMapController;
         control.animateCamera(CameraUpdate.newCameraPosition(
           const CameraPosition(
             target: LatLng(27.0238, 74.2179),
           )
         ),
             );
         setState(() {

         });
      },


      ),
    );
  }
}

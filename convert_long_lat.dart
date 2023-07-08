import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLongLat extends StatefulWidget {
  const ConvertLongLat({Key? key}) : super(key: key);

  @override
  State<ConvertLongLat> createState() => _ConvertLongLatState();
}

class _ConvertLongLatState extends State<ConvertLongLat> {
  String stAddress = '';
  String add = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Google Map")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(add),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress("Gronausestraat 710, Enschede");
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(52.2165157, 6.9437819);
              setState(() {
                stAddress = locations.last.longitude.toString() +
                    locations.last.latitude.toString();

                add = placemarks.reversed.last.country.toString()+" " +placemarks.reversed.last.isoCountryCode.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                height: 60,
                child: const Center(child: Text("Convert")),
              ),
            ),
          )
        ],
      ),
    );
  }
}

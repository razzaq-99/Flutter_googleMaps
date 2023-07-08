import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  final TextEditingController _controller = TextEditingController();

  var uuid = Uuid();
  String _sessionToken = "12345";

  List<dynamic> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String _KPlaces_Api_key = "AIzaSyCAhfkgm8BTlgBeUUYmtaw3SQPHNd-MQA4";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$_KPlaces_Api_key&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _list = jsonDecode(response.body.toString())['predictions'];
      });

    }
    else {
      throw Exception('Failed to load Data:');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Google Places Api ")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: "Search places with Names:"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _list.length ,
                  itemBuilder: (context,index){
                   return ListTile(
                     title: _list[index]['description'],
                   );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class ShowLocation extends StatefulWidget {
  @override
  _ShowLocationState createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {
  var locationmesaage = "";
  var _currentAddress = "";

  String _timeString;

  double get lat => null;

  double get lng => null;

  void getCurrentLocation() async {
    var postion = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var pastposition = await Geolocator().getLastKnownPosition();
    List<Placemark> p = await Geolocator()
        .placemarkFromCoordinates(postion.latitude, postion.longitude);

    Placemark place = p[0];

    var lat = postion.latitude;
    var lng = postion.longitude;

    print(pastposition);
    setState(() {
      locationmesaage = "Latitude : $lat\nLongitude: $lng";
      _currentAddress =
          "Address: ${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
    });
  }

  @override
  void initState() {
     getCurrentLocation();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 50.0,
              color: Colors.blue,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('Get Location',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$locationmesaage'),
                Text('$_currentAddress'),
                Text('Time : $_timeString'),
              ],
            ),
            // FlatButton(
            //   onPressed: () {
            //     getCurrentLocation();
            //   },
            //   color: Colors.blue[600],
            //   child: Text(
            //     'GET LOCATION',
            //     style: TextStyle(color: Colors.white),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }
}

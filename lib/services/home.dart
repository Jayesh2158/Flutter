import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  final String name;
  final String image;
  const Home({Key key, @required this.name, @required this.image})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double> latLag;
  GoogleMapController _controller;
  Position position;
  Widget _child;
  @override
  void initState() {
    //_child=RippleIndicator("Getting Location");
    getLocation();
    super.initState();
  }

  getLocation() async {
    Position res = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('no1'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'Your are here'),
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello ${widget.name}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: Image.file(
                File(widget.image),
                fit: BoxFit.fitHeight,
              ).image,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 700, width: 400, child: _child),
            SizedBox(height: 15),
            SizedBox(
              width: 150,
              height: 40,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/gridView'),
                child: Container(
                  height: 40,
                  width: 150,
                  color: Colors.deepPurple,
                  child: Center(
                    child: Text(
                      'Second Screen',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mapWidget() {
    return GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _createMarker(),
        initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17.4746,
        ));
  }
}

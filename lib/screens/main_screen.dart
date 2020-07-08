import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String SCREEN_PATH = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GoogleMapController _controller;
  Set<Marker> _markers = Set<Marker>();

  static const CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(35.0, 135.0), zoom: 9.0);
  Position _currentPosition;

  Future<void> getCurrentPosition() async {
    _currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    print('The user location. longitude:${_currentPosition.longitude}, latitude:${_currentPosition.latitude}');
  }

  LatLng _getCenterPosition(LatLngBounds latlngbounds) {
    print('topleft:( ${latlngbounds.northeast.latitude} , ${latlngbounds.northeast.longitude} ) '
        'bottomright:( ${latlngbounds.southwest.latitude} , ${latlngbounds.southwest.longitude} )');

    LatLng centerPos = LatLng(
        (latlngbounds.northeast.latitude + latlngbounds.southwest.latitude) / 2, (latlngbounds.northeast.longitude + latlngbounds.southwest.longitude) / 2);

    print('Center Position: ${centerPos.latitude}, ${centerPos.longitude}');
    return centerPos;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              this._controller = controller;
            },
            markers: this._markers,
          ),
        ),
        Positioned(
          bottom: 60.0,
          left: 20.0,
          child: FlatButton(
            child: Text('Get and go to the current position'),
            color: Color(0x7fffffff),
            onPressed: () async {
              await this.getCurrentPosition();

              await this._controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        this._currentPosition.latitude,
                        this._currentPosition.longitude,
                      ),
                      zoom: await this._controller.getZoomLevel(),
                    ),
                  ));
            },
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 20.0,
          child: FlatButton(
            child: Text('Put a pin on the current camera position.'),
            color: Color(0x7fffffff),
            onPressed: () async {
              //
              // Retrieve and calculate the current center position of the Map.
              //
              LatLngBounds latlngbounds = await this._controller.getVisibleRegion();
              LatLng centerPos = this._getCenterPosition(latlngbounds);

              //
              // Create and put a marker to the Google Map.
              //
              String markerIdStr = 'markerId_' + DateTime.now().millisecondsSinceEpoch.toString();
              MarkerId markerId = MarkerId(markerIdStr);

              Marker marker = Marker(
                markerId: markerId,
                position: centerPos,
                infoWindow: InfoWindow(title: markerIdStr, snippet: markerIdStr),
                onTap: () {},
              );

              setState(() {
                this._markers.add(marker);
              });

              print('There are "${this._markers.length}" markers. "Markers":${this._markers}');
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gisgustbuttonflutter/models/user_disgust.dart';
import 'package:gisgustbuttonflutter/screens/login_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String SCREEN_PATH = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const CameraPosition _initialCameraPosition = CameraPosition(target: LatLng(35.0, 135.0), zoom: 9.0);

  // Initializing Firebase objects.
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Firestore _firestore = Firestore.instance;

  // Properties used within this screen.
  Position _userPosition;
  GoogleMapController _controller;
  CameraPosition _cameraPosition = _initialCameraPosition;
  Set<Marker> _markers = Set<Marker>();

  // This method obtain where the user is by using the Geolocator API.
  // https://pub.dev/packages/geolocator
  //
  Future<void> getCurrentPosition() async {
    _userPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    print('The user location. longitude:${_userPosition.longitude}, latitude:${_userPosition.latitude}');
  }

  //
  // Creates and puts a marker to the Google Map.
  // Stores the marker information to Firestore.
  //
  void _putAndRecordPin() async {
    int unixEpochMs = DateTime.now().millisecondsSinceEpoch;
    String markerIdStr = 'markerId_${this._user.uid}_${unixEpochMs.toString()}';

    // Create an UserDisgust object for storing it to Firestore.
    UserDisgust disgust = UserDisgust(
      markerId: markerIdStr,
      userId: this._user.uid,
      coords: GeoFirePoint(this._cameraPosition.target.latitude, this._cameraPosition.target.longitude),
      datetime: unixEpochMs,
    );

//    this._firestore.collection(UserDisgust.firestoreCollectionName).add();
    print(disgust);

    // Create a Marker object for GoogleMap.
    MarkerId markerId = MarkerId(markerIdStr);
    Marker marker = Marker(
      markerId: markerId,
      position: this._cameraPosition.target,
      infoWindow: InfoWindow(title: markerIdStr, snippet: markerIdStr),
    );

    setState(() {
      this._markers.add(marker);
    });

    print('There are "${this._markers.length} markers.');
    //              this._markers.forEach((marker) {
    //                print('${marker.markerId.value}:(${marker.position.latitude}, ${marker.position.longitude})');
    //              });
  }

  void _updateCurrentUser() async {
    try {
      FirebaseUser user = await this._auth.currentUser();
      print('An user is logged in. username:"${user.email}"');
      setState(() {
        this._user = user;
      });
    } catch (e) {
      print('No user is logged in.');
      print(e);
      setState(() {
        this._user = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this._updateCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            child: GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) async {
                this._controller = controller;
              },
              onCameraMove: (CameraPosition position) {
                this._cameraPosition = position;
//                print('Current camera position: ${position}');
              },
              markers: this._markers,
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            right: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Text(
                    this._user != null ? '${this._user.email} logged in.' : 'You are not logged in.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      color: Color(0x7fffffff),
                      child: Text(
                        this._user != null ? 'Logout' : 'Login',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      onPressed: this._user != null
                          ? () {
                              this._auth.signOut();
                              this._updateCurrentUser();
                            }
                          : () {
                              Navigator.popAndPushNamed(context, LoginScreen.SCREEN_PATH);
                            }),
                ),
              ],
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
                          this._userPosition.latitude,
                          this._userPosition.longitude,
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
              onPressed: this._user != null ? _putAndRecordPin : null,
            ),
          ),
        ],
      ),
    );
  }
}

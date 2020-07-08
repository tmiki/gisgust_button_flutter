import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserDisgust {
  UserDisgust({this.markerId, this.userId, this.coords, this.datetime});

  static const String firestoreCollectionName = 'user_disgusts';

  final String markerId;
  final String userId;
  final int datetime;
  final GeoPoint coords;

  String toString() {
    return this.convertMap().toString();
  }

  Map<String, dynamic> convertMap() {
    return {
      "markerId": this.markerId,
      "userId": this.userId,
      "datetime": this.datetime,
      "coords": {"latitude": this.coords.latitude, "longitude": this.coords.longitude}
    };
  }
}

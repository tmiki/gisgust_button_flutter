import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserDisgust {
  UserDisgust({this.markerId, this.userId, this.coords, this.datetime});

  static const String firestoreCollectionName = 'user_disgusts';

  final String markerId;
  final String userId;
  final GeoFirePoint coords;
  final int datetime;
}

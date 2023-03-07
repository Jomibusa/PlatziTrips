import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';

class CloudFireStoreRepository {
  final _cloudFireStoreAPI = CloudFirestoreAPI();

  void updateUserDataFireStore(UserModel user) =>
      _cloudFireStoreAPI.updateUserData(user);

  Future<void> updatePlaceData(InfoPlace place) =>
      _cloudFireStoreAPI.updatePlaceData(place);
}

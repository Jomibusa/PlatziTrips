import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';
import '../ui/widgets/profile_place.dart';

class CloudFireStoreRepository {
  final _cloudFireStoreAPI = CloudFirestoreAPI();

  void updateUserDataFireStore(UserModel user) =>
      _cloudFireStoreAPI.updateUserData(user);

  Future<void> updatePlaceData(PlaceModel place) =>
      _cloudFireStoreAPI.updatePlaceData(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFireStoreAPI.buildMyPlaces(placesListSnapshot);

  List<PlaceModel> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, UserModel user) =>
      _cloudFireStoreAPI.buildPlaces(placesListSnapshot, user);

  Future likePlace(PlaceModel place, String uid) =>
      _cloudFireStoreAPI.likePlace(place, uid);
}

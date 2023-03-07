import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/Place/model/place.dart';

class CloudFirestoreAPI {
  static const String users = 'users';
  static const String places = 'places';

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(UserModel user) async {
    CollectionReference usersCollection =
        _db.collection(CloudFirestoreAPI.users);
    DocumentReference ref = usersCollection.doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(InfoPlace place) async {
    CollectionReference refPlaces = _db.collection(CloudFirestoreAPI.places);
    User? currentUser = _auth.currentUser;

    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': "${CloudFirestoreAPI.users}/${currentUser?.uid}"
    });
  }
}

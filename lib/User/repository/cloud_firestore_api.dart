import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_place.dart';

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
      'userOwner': _db.doc("${CloudFirestoreAPI.users}/${currentUser?.uid}"),
      'urlImage': place.urlImage
    }).then((value) {
      value.get().then((value) {
        DocumentReference placeRef = value.reference;
        DocumentReference refUsers =
            _db.collection(CloudFirestoreAPI.users).doc(currentUser?.uid);
        refUsers.update({
          'myPlaces': FieldValue.arrayUnion([placeRef])
        });
      });
    });
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = <ProfilePlace>[];
    for (var element in placesListSnapshot) {
      profilePlaces.add(ProfilePlace(InfoPlace(
          likes: element['likes'],
          name: element['name'],
          description: element['description'],
          urlImage: element['urlImage'])));
    }
    return profilePlaces;
  }

  List<CardImageWithFabIcon> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot) {
    List<CardImageWithFabIcon> profilePlaces = <CardImageWithFabIcon>[];
    for (var element in placesListSnapshot) {
      profilePlaces.add(CardImageWithFabIcon(20,
          pathImage: element['urlImage'],
          width: 300.0,
          height: 350.0,
          onPressedFabIcon: () {},
          iconData: Icons.favorite_border));
    }
    return profilePlaces;
  }
}

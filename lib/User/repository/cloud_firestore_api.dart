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

  Future<void> updatePlaceData(PlaceModel place) async {
    CollectionReference refPlaces = _db.collection(CloudFirestoreAPI.places);
    User? currentUser = _auth.currentUser;

    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': _db.doc("${CloudFirestoreAPI.users}/${currentUser?.uid}"),
      'urlImage': place.urlImage,
      'usersLiked': FieldValue.arrayUnion([])
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
      profilePlaces.add(ProfilePlace(PlaceModel(false,
          likes: element['likes'],
          name: element['name'],
          description: element['description'],
          urlImage: element['urlImage'])));
    }
    return profilePlaces;
  }

  //Metodo para mostrar todos los Places en la pantalla de home
  //Asi como definir que Places ya se le ha dado like por parte
  //del usuario loguado
  List<PlaceModel> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, UserModel user) {
    List<PlaceModel> profilePlaces = <PlaceModel>[];
    for (var place in placesListSnapshot) {
      PlaceModel currentPlace = PlaceModel(false,
          id: place.id,
          name: place['name'],
          description: place['description'],
          urlImage: place['urlImage'],
          likes: place['likes']);
      List usersLikedRefs =  place['usersLiked']??[];
      currentPlace.liked = false;
      for (var drUL in usersLikedRefs) {
        if(user.uid == drUL.id){
          currentPlace.liked = true;
        }
      }
      profilePlaces.add(currentPlace);
    }
    return profilePlaces;
  }

  //Metodo para incrementar en 1 los likes de un PLACE
  //Primero se obtiene los likes que tiene actualmente el PLACE utilizando el "idPlace"
  //Despues se le incrementa en 1 y se guarda en la Base de datos de CloudFirebase
  Future likePlace(PlaceModel place, String uid) async {
    await _db
        .collection(CloudFirestoreAPI.places)
        .doc(place.id)
        .get()
        .then((value) {
      int likes = value['likes'];
      _db.collection(places).doc(place.id).update({
        'likes': place.liked ? likes + 1 : likes - 1,
        'usersLiked': place.liked
            ? FieldValue.arrayUnion(
                [_db.doc("${CloudFirestoreAPI.users}/$uid")])
            : FieldValue.arrayRemove(
                [_db.doc("${CloudFirestoreAPI.users}/$uid")])
      });
    });
  }
}

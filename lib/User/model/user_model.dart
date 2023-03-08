import 'package:flutter/material.dart';

import '../ui/widgets/profile_place.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoURL;
  final List<ProfilePlace>? myPlaces;
  final List<ProfilePlace>? myFavoritePlaces;

  //myFavoritePlaces
  //myPlaces

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
    this.myFavoritePlaces,
    this.myPlaces,
  });
}

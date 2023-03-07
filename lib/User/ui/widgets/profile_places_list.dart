import 'package:flutter/material.dart';
import 'profile_place.dart';
import 'package:platzi_trips_app/Place/model/place.dart';

class PlacesList extends StatelessWidget {
  InfoPlace place = InfoPlace(
      name: "Knuckles Mountains Range",
      description: "Hiking. Water fall hunting. Natural bath",
      urlImage:
          "https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
      likes: 3,
      userOwner: null);
  InfoPlace place2 = InfoPlace(
      name: "Mountains",
      description:
          "Hiking. Water fall hunting. Natural bath’, 'Scenery & Photography",
      urlImage:
          "https://images.unsplash.com/photo-1524654458049-e36be0721fa2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
      likes: 10,
      userOwner: null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),
    );
  }
}

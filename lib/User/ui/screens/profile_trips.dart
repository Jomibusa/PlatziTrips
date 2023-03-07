import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/ui/screens/header_profile.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_background.dart';
import '../widgets/profile_places_list.dart';

class ProfileTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackgroundProfile(),
        ListView(
          children: <Widget>[HeaderProfile(), PlacesList()],
        ),
      ],
    );
  }
}

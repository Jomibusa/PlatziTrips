import 'package:flutter/material.dart';
import 'profile_place_info.dart';
import 'package:platzi_trips_app/Place/model/place.dart';

class ProfilePlace extends StatelessWidget {

  InfoPlace infoPlace;

  ProfilePlace(this.infoPlace);

  @override
  Widget build(BuildContext context) {

    final photoCard = Container(
      margin: const EdgeInsets.only(
          top: 10.0,
          bottom: 70.0
      ),
      height: 220.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              //image: AssetImage(infoPlace.urlImage)
              image: NetworkImage(infoPlace.urlImage)
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: Colors.red,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0)
            )
          ]
      ),
    );

    return Stack(
      alignment: const Alignment(0.0, 0.8),
      children: <Widget>[
        photoCard,
        PlaceInfo(infoPlace)
      ],
    );
  }

}

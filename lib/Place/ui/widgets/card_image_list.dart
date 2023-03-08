import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import '../../../User/model/user_model.dart';
import 'card_image.dart';

class CardImageList extends StatefulWidget {
  final UserModel user;

  const CardImageList({super.key, required this.user});

  @override
  State createState() {
    return _CardImageList();
  }
}

class _CardImageList extends State<CardImageList> {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SizedBox(
          height: 350.0,
          child: StreamBuilder(
            stream: userBloc.placesStream,
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const CircularProgressIndicator();
                case ConnectionState.active:
                case ConnectionState.done:
                  return listViewPlaces(
                      userBloc.buildPlaces(snapshot.data.docs, widget.user));
              }
            },
          ),
        ));
  }

  Widget listViewPlaces(List<PlaceModel> places) {
    //Metodo para desencadenar las acciones al dar like o dislike con el boton del Heart
    void setLiked(PlaceModel place) {
      setState(() {
        place.liked = !place.liked;
        userBloc.likePlace(place, widget.user.uid);
        place.likes = place.liked ? place.likes! + 1 : place.likes! - 1;
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;

    return ListView(
      padding: const EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return CardImageWithFabIcon(20,
            pathImage: place.urlImage ?? '',
            width: 300.0,
            height: 250.0,
            iconData: place.liked ? iconDataLiked : iconDataLike,
            onPressedFabIcon: () {
          setLiked(place);
        });
      }).toList(),
    );
  }
}

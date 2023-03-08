import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/widgets/button_purple.dart';
import '../../../User/bloc/bloc_user.dart';

class DescriptionPlace extends StatelessWidget {
  String namePlace;
  int stars;
  String descriptionPlace;

  DescriptionPlace(this.namePlace, this.stars, this.descriptionPlace,
      {super.key});

  final star = Container(
    margin: const EdgeInsets.only(top: 360.0, right: 3.0),
    child: const Icon(
      Icons.star,
      color: Color(0xFFF2C611),
    ),
  );

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);
    /*final star_half = Container(
        margin: const EdgeInsets.only(top: 360.0, right: 3.0),
        child: const Icon(
          Icons.star_half,
          color: Color(0xFFF2C611),
        ));

    final star_border = Container(
        margin: const EdgeInsets.only(top: 360.0, right: 3.0),
        child: const Icon(
          Icons.star_border,
          color: Color(0xFFF2C611),
        ));

    final description = Container(
      margin: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: Text(
        descriptionPlace,
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)),
      ),
    );

    final title_stars = Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 360.0, left: 20.0, right: 20.0),
          child: Text(
            namePlace,
            style:
                GoogleFonts.lato(fontSize: 30.0, fontWeight: FontWeight.w900),
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          children: [star, star, star, star, star_border],
        )
      ],
    );*/

    return StreamBuilder(
      stream: userBloc.placeSelectedStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          PlaceModel place = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleStars(place),
              descriptionWidget(place.description),
              ButtonPurple(
                buttonText: "Navigate",
                onPressed: () {},
                width: 200.0,
                height: 50.0,
              )
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
                child: const Text(
                  "Selecciona un lugar",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget titleStars(PlaceModel place) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 350.0, left: 20.0, right: 20.0),
          child: Text(
            place.name,
            style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 30.0,
                fontWeight: FontWeight.w900),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 370.0,
          ),
          child: Text(
            "Likes: ${place.likes}",
            style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: Colors.red),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget descriptionWidget(String descriptionPlace) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Text(
        descriptionPlace,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)),
      ),
    );
  }
}

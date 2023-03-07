import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/ui/widgets/text_input_location.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/text_input.dart';

import '../../../User/bloc/bloc_user.dart';
import '../../../widgets/button_purple.dart';
import '../../../widgets/title_header.dart';
import '../widgets/card_image.dart';

class AddPlaceScreen extends StatefulWidget {
  final File? image;

  const AddPlaceScreen({super.key, this.image}); //Constructor
  @override
  State<StatefulWidget> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends State<AddPlaceScreen> {
  final _controllerTitlePlace = TextEditingController();
  final _controllerDescriptionPlace = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Stack(
        children: [
          GradientBack(
            height: 300.0,
            title: '',
          ),
          appBar(),
          //Widgets debajo del AppBar
          Container(
            margin: const EdgeInsets.only(top: 100.0, bottom: 20.0),
            child: ListView(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    alignment: Alignment.center,
                    child: CardImageWithFabIcon(0,
                        pathImage: widget.image?.path??"assets/img/rio.jpeg",
                        width: 300.0,
                        height: 250.0,
                        onPressedFabIcon: () {},
                        iconData: Icons.camera_alt)), // Foto del Place
                Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextInput(
                    fontSize: 16.0,
                    hintText: "Title",
                    inputType: null,
                    controller: _controllerTitlePlace,
                    maxLines: 1,
                  ),
                ),
                TextInput(
                  fontSize: 14.0,
                  hintText: "Description",
                  inputType: TextInputType.multiline,
                  controller: _controllerDescriptionPlace,
                  maxLines: 4,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: const TextInputLocation(
                      hintText: "Add Location",
                      fontSize: 14.0,
                      iconData: Icons.location_on_outlined),
                ),
                Container(
                    width: 70.0,
                    child: ButtonPurple(
                      buttonText: "Add Place",
                      onPressed: () {
                        //Firebase storage
                        //url
                        //cloud firestores
                        //place - title - description- url
                        userBloc
                            .updatePlaceData(InfoPlace(
                                name: _controllerTitlePlace.text,
                                description: _controllerDescriptionPlace.text,
                                urlImage: "urlImage",
                                likes: 0))
                            .whenComplete(() {
                          print("TERMINO");
                          Navigator.pop(context);
                        });
                      },
                      width: 200.0,
                      height: 50.0,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(top: 25.0, left: 5.0),
            child: SizedBox(
                //delimita el espacio para hacer click y regresar a la pantalla anterior
                width: 45.0, //Espacio establecido
                height: 45.0,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left,
                        color: Colors.white, size: 45.0)))),
        Flexible(
            child: Container(
          padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
          child: const TitleHeader(title: "Add a new Place"),
        ))
      ],
    );
  }
}

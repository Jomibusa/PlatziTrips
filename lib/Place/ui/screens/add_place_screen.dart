import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
                        pathImage: widget.image?.path ?? "assets/img/rio.jpeg",
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
                        const CircularProgressIndicator();
                        //1. Firebase Storage
                        //url -
                        //Id del usuario logeado actualmente
                        userBloc.currentUser().then((User? user) {
                          if (user != null) {
                            String uid = user.uid;
                            String path =
                                "${uid}/${DateTime.now().toString()}.jpg";
                            //change RULE in Firebase Storage console to = allow read, write: if request.auth != null;
                            userBloc
                                .uploadFile(path, widget.image ?? File(""))
                                .then((UploadTask uploadTask) {
                              uploadTask.then((TaskSnapshot snapshot) {
                                snapshot.ref.getDownloadURL().then((urlImage) {
                                  print("URLIMAGE: ${urlImage}");
                                  //2. Cloud Firestore
                                  //Place - title, description, url, userOwner, likes
                                  userBloc
                                      .updatePlaceData(InfoPlace(
                                          name: _controllerTitlePlace.text,
                                          description:
                                              _controllerDescriptionPlace.text,
                                          likes: 0,
                                          urlImage: urlImage))
                                      .whenComplete(() {
                                    print("Termino");
                                    Navigator.pop(context);
                                  });
                                });
                              });
                            });
                          }
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

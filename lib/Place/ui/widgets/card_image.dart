import 'dart:io';

import 'package:flutter/material.dart';

import '../../../widgets/floating_action_button_green.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final String pathImage;
  final double height;
  final double width;
  final double left;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;

  const CardImageWithFabIcon(this.left,
      {super.key,
      required this.pathImage,
      required this.width,
      required this.height,
      required this.onPressedFabIcon,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> image;
    //Selleciona que tipo de imagen se va a mostrar. local, de camara, de internet
    if (pathImage.contains("assets")) {
      image = AssetImage(pathImage);
    } else if (pathImage.contains("https:")) {
      image = NetworkImage(pathImage);
    } else {
      image = FileImage(File(pathImage));
    }

    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: left),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              //image: AssetImage(pathImage),
              image: image),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.7))
          ]),
    );

    return Stack(
      alignment: const Alignment(0.9, 1.1),
      children: [
        card,
        FloatingActionButtonGreen(
          iconData: iconData,
          onPressed: () {
            onPressedFabIcon();
          },
        )
      ],
    );
  }
}

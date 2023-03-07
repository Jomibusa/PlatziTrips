import 'package:flutter/material.dart';
import 'card_image.dart';

class CardImageList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 350.0,
        child: ListView(
          padding: const EdgeInsets.all(25.0),
          scrollDirection: Axis.horizontal,
          children: [
            CardImage("assets/img/rio.jpeg"),
            CardImage("assets/img/teleferico.jpeg"),
            CardImage("assets/img/montanas.jpeg"),
            CardImage("assets/img/extremo.jpeg"),
            CardImage("assets/img/piscina.jpeg"),
            CardImage("assets/img/paracaidas.jpeg")
          ],
        ),
    );
  }
}
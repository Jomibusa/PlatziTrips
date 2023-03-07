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
          CardImageWithFabIcon(20,
              pathImage: "assets/img/rio.jpeg",
              width: 300.0,
              height: 200.0,
              onPressedFabIcon: () {},
              iconData: Icons.favorite_border),
          CardImageWithFabIcon(20,
              pathImage: "assets/img/teleferico.jpeg",
              width: 300.0,
              height: 200.0,
              onPressedFabIcon: () {},
              iconData: Icons.favorite_border),
          CardImageWithFabIcon(20,
              pathImage: "assets/img/montanas.jpeg",
              width: 300.0,
              height: 200.0,
              onPressedFabIcon: () {},
              iconData: Icons.favorite_border),
          CardImageWithFabIcon(20,
              pathImage: "assets/img/extremo.jpeg",
              width: 300.0,
              height: 200.0,
              onPressedFabIcon: () {},
              iconData: Icons.favorite_border),
          CardImageWithFabIcon(20,
              pathImage: "assets/img/piscina.jpeg",
              width: 300.0,
              height: 200.0,
              onPressedFabIcon: () {},
              iconData: Icons.favorite_border),
          CardImageWithFabIcon(20,
              pathImage: "assets/img/paracaidas.jpeg",
              width: 300.0,
              height: 200.0,
              onPressedFabIcon: () {},
              iconData: Icons.favorite_border),
        ],
      ),
    );
  }
}

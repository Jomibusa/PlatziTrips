import 'package:flutter/material.dart';
import '../../../widgets/floating_action_button_green.dart';

class CardImage extends StatelessWidget {

  String pathImage = "assets/img/rio.jpeg";

  bool pressed = false;

  CardImage(this.pathImage);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: 250.0,
      width: 250.0,
      margin: const EdgeInsets.only(
          top: 80.0,
          left: 20.0
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: AssetImage(pathImage),
          ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15.0,
            offset: Offset(0.0, 0.7)
          )
        ]
      ),
    );

    return Stack(
      alignment: const Alignment(0.9, 1.1),
      children: [
        card,
        FloatingActionButton(onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Agregaste a Favoritos"),
              )
          );
        },)
      ],
    );
  }
}
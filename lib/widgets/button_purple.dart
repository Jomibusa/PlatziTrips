import 'package:flutter/material.dart';

class ButtonPurple extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const ButtonPurple(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4268D3),
                      Color(0xFF584CD1),
                    ],
                    begin: FractionalOffset(0.2, 0.0),
                    end: FractionalOffset(1.0, 0.6),
                    stops: [0.0, 0.6],
                    tileMode: TileMode.clamp)),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(
                    fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
              ),
            ),
          ),
        ));
  }
}

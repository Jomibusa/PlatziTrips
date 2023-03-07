import 'package:flutter/material.dart';

class FloatigActionButtonGreen extends StatefulWidget {
  @override
  State createState() {
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatigActionButtonGreen> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      mini: true,
      tooltip: "Fav",
      heroTag: null,
      child: const Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }
}

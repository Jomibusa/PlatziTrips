import 'package:flutter/material.dart';

class FloatingActionButtonRed extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const FloatingActionButtonRed(
      {super.key, required this.iconData, required this.onPressed});

  @override
  State createState() {
    return _FloatingActionButtonRed();
  }
}

class _FloatingActionButtonRed extends State<FloatingActionButtonRed> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFFFF0000),
      onPressed: widget.onPressed,
      mini: true,
      tooltip: "Fav",
      heroTag: null,
      child: Icon(
        widget.iconData,
        color: Colors.white,
      ),
    );
  }
}

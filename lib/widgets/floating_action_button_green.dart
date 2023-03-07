import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const FloatingActionButtonGreen(
      {super.key, required this.iconData, required this.onPressed});

  @override
  State createState() {
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF11DA53),
      onPressed: widget.onPressed,
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

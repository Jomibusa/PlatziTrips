import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rating.dart';

class Review extends StatelessWidget {
  String name = "José Bueno";
  String details = "1 reviews 5 photos";
  String comment = "There is amazing place in Bucaramanga";
  double stars = 5;

  Review(this.name, this.details, this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    final userComment = Container(
      margin: const EdgeInsets.only(left: 20.0),
      child: Text(comment,
          textAlign: TextAlign.left,
          style: GoogleFonts.lato(fontSize: 10.0, fontWeight: FontWeight.w900)),
    );

    final userInfo = Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0),
          child: Text(details,
              textAlign: TextAlign.left,
              style: GoogleFonts.lato(
                  fontSize: 13.0, color: const Color(0xFFa3a5a7))),
        ),
        Rating(stars, 5.0, 14.0)
      ],
    );

    final userName = Container(
      margin: const EdgeInsets.only(left: 20.0),
      child: Text(name,
          textAlign: TextAlign.left, style: GoogleFonts.lato(fontSize: 17.0)),
    );

    final userDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [userName, userInfo, userComment],
    );

    final photo = Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0),
      width: 80.0,
      height: 80.0,
      child: const CircleAvatar(
        backgroundImage: AssetImage("assets/img/chicamocha.jpeg"),
      ),
    );

    return Row(
      children: [photo, userDetails],
    );
  }
}

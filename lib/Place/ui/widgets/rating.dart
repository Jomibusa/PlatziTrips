import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  double stars;
  double marginLeft;
  double fontSize;

  Rating(this.stars, this.marginLeft, this.fontSize);

  Widget getStar(double star) {
    var icon = Icon(
      Icons.star,
      color: const Color(0xFFf2C611),
      size: fontSize,
    );

    if (star == 0.5) {
      icon = Icon(
        Icons.star_half,
        color: const Color(0xFFf2C611),
        size: fontSize,
      );
    } else {
      if (star < 0.5) {
        icon = Icon(
          Icons.star_border,
          color: const Color(0xFFa3a5a7),
          size: fontSize,
        );
      }
    }

    return Container(margin: const EdgeInsets.only(right: 1.0), child: icon);
  }

  Widget getRating(double stars) {
    var star_list = <Widget>[];

    for (var n = 0; n < 5; n++) {
      star_list.add(getStar(stars));
      stars--;
    }
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      child: Row(
        children: star_list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getRating(stars);
  }
}

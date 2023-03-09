import 'package:flutter/material.dart';
import '../widgets/review_list.dart';
import 'header_appbar.dart';
import '../widgets/description_place.dart';

class HomeTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [DescriptionPlace(), const ReviewList()],
        ),
        const HeaderAppBar(),
      ],
    );
  }
}

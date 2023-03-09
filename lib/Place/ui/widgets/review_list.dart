import 'package:flutter/material.dart';
import 'review.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Review("Jose Bueno", "1 reviews 5 photos",
            "There is amazing place in Bucaramanga"),
        Review("Jose Bueno", "1 reviews 5 photos",
            "There is amazing place in Bucaramanga"),
        Review("Jose Bueno", "1 reviews 5 photos",
            "There is amazing place in Bucaramanga")
      ],
    );
  }
}

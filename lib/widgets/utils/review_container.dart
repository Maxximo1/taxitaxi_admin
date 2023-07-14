import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../helpers/style.dart';

class ReviewContainer extends StatelessWidget {
  final Map review;
  const ReviewContainer({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFABB2BA), width: .5)),
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                review["userImage"] == null || review["userImage"] == ""
                    ? CircleAvatar(
                        radius: 22.5,
                        backgroundColor: primaryColor,
                        child: Text(
                          review["userName"].toString().length > 2
                              ? review["userName"].substring(0, 2)
                              : " -",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -.8,
                              color: Colors.white),
                        ),
                      )
                    : CircleAvatar(
                        radius: 22.5,
                        backgroundImage: NetworkImage(review["userImage"]),
                      ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text(
                        review["userName"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            height: 1.2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(DateTime.parse(review["ratingDate"])),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    RatingBar(
                      initialRating: review["stars"].toDouble(),
                      minRating: 0,
                      glow: false,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 12,
                      unratedColor: const Color(0xFF9FA8B0),
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          empty: const Icon(
                            Icons.star_border_outlined,
                            color: Colors.amber,
                          ),
                          half: const Icon(
                            Icons.star_half_outlined,
                            color: Colors.amber,
                          ),
                          full: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          )),
                      itemPadding: const EdgeInsets.symmetric(horizontal: .0),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 12, bottom: 6),
            child: Text(review["desc"],
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: const TextStyle(
                  height: 1.4,
                  letterSpacing: 1.3,
                  fontSize: 15,
                )),
          )
        ],
      ),
    );
  }
}

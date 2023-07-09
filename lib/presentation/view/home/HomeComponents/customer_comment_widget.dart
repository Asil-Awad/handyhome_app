import 'package:flutter/material.dart';
import 'package:handy_home_app/presentation/view/home/HomeComponents/stare_rating_widget.dart';

import '../../../resources/style_manager.dart';

class CustomerCommentWidget extends StatelessWidget {
  const CustomerCommentWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.comment,
    required this.rating,
  }) : super(key: key);
  final String name;
  final String image;
  final String comment;
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
                fit: BoxFit.contain,
              ),
              clipBehavior: Clip.antiAlias,
            ),
            Text(
              name.length < 3 ? 'اسم افتراضي' : name,
              style: StyleManger.headline1(fontSize: 14),
            ),
            const Spacer(),
            StareRatingWidget(ratingNumber: rating.toString())
          ],
        ),
        Text(
          comment,
          style: StyleManger.headline2(),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoujinCards extends StatefulWidget {
  DoujinCards(
      {Key? key,
      required this.cover,
      required this.mediaId,
      required this.title,
      required this.rating,
      required this.id})
      : super(key: key);

  final String cover;
  final String title;
  final int rating;
  final String mediaId;
  final int id;

  @override
  State<DoujinCards> createState() => _DoujinCards();
}

class _DoujinCards extends State<DoujinCards> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network('https://via.placeholder.com/500x500'),
                // TODO: For testing purposes, remove later
                // 'https://t.nhentai.net/galleries/${doujin?.mediaId}/cover.${doujin?.cover == 'j' ? 'jpg' : 'png'}'
              )),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 10.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.down,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                RatingBarIndicator(
                  rating: widget.rating.toDouble(),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        )),
                // TODO: Add star rating
              ],
            ),
          )
        ],
      ),
      // TODO: Add on click event to move to details page
    );
  }
}

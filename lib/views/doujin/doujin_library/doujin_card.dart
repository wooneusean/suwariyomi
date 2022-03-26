import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:suwariyomi/classes/doujin.dart';

class DoujinCard extends StatelessWidget {
  DoujinCard(
    this.doujin, {
    Key? key,
  }) : super(key: key);

  final Doujin doujin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                doujin.getCoverUrl(),
              ),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: [0, 0.60],
                colors: [Colors.black.withOpacity(0.75), Colors.black.withOpacity(0)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  doujin.title.pretty,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: RatingBarIndicator(
                    rating: doujin.rating.toDouble(),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.of(context).pushNamed(
          '/details',
          arguments: doujin.id,
        )
      },
    );
  }
}

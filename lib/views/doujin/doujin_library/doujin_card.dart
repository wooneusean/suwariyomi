import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:suwariyomi/classes/doujin.dart';

import '../doujin_details/doujin_details_view_args.dart';

class DoujinCard extends StatelessWidget {
  DoujinCard(
    this.doujin,
    this.callback, {
    Key? key,
  }) : super(key: key);

  final Doujin doujin;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black.withOpacity(0.9), Colors.black.withOpacity(0)],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 3.5),
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Text(
                        doujin.title.pretty,
                        maxLines: 1,
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
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.of(context).pushNamed(
          '/details',
          arguments: DoujinDetailsViewArgs(doujin.id, callback),
        )
      },
    );
  }
}

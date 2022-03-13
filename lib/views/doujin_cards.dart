import 'package:flutter/material.dart';


class DoujinCard extends StatelessWidget {

  // Card should have the preview
  // Card should have the name
  // card should have the rating
  // card should have the short summary?

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      children: [
        Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.blue,
            child: Text('what')
        ),
        Container(
            padding: EdgeInsets.all(30.0),
            color: Colors.red,
            child: Text('Are')
        ),
        Container(
            padding: EdgeInsets.all(40.0),
            color: Colors.green,
            child: Text('You')
        ),
        Container(
            padding: EdgeInsets.all(40.0),
            color: Colors.green,
            child: Text('You')
        ),
        Container(
            padding: EdgeInsets.all(40.0),
            color: Colors.green,
            child: Text('You')
        ),
        Container(
            padding: EdgeInsets.all(40.0),
            color: Colors.green,
            child: Text('You')
        ),
        Container(
            padding: EdgeInsets.all(40.0),
            color: Colors.green,
            child: Text('You')
        )
      ],
    );
  }
}
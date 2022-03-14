import 'dart:core';

import 'package:flutter/material.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_view_args.dart';
import 'package:suwariyomi/classes/doujin.dart';
import 'doujin_card.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Doujin>? doujins;
  bool isLoading = true;

  void _retrieveDoujins() {
    setState(() {
      isLoading = true;
      // TODO : Remove
      doujins = [
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
        Doujin(
            dateAdded: 1023,
            uploadDate: 1231,
            cover: 'dasd',
            scanlator: null,
            rating: 3,
            mediaId: '1234647',
            id: 1234,
            title: null,
            tags: null),
      ];
    });

    // TODO: for real use case
    /*var doujinProvider = DoujinProvider();

    doujinProvider.retrieveAll().then((value) {
      setState(() {
        doujins = value;
        isLoading = false;
      });
    });*/
  }

  @override
  void initState() {
    super.initState();
    _retrieveDoujins();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.3),
        ),
        itemCount: doujins?.length ?? 0,
        itemBuilder: (context, index) {
          final item = doujins?[index];

          return GridTile(
            child: DoujinCard(
                cover: item?.cover ?? 'Error',
                mediaId: item?.mediaId ?? 'Error',
                //TODO: change string to title
                title: item?.title.toString() ?? 'hasbdyb asd vb',
                rating: item?.rating ?? 4,
                id: item?.id ?? 123123),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: For testing purposes, remove later
          Navigator.of(context).pushNamed(
            '/details',
            arguments: DoujinDetailsViewArgs(101113),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

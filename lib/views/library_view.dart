import 'package:flutter/material.dart';
import 'package:suwariyomi/classes/doujin.dart';
import './doujin_cards.dart';

List<Doujin> doujins = [
  Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
  Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
  Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
  Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
];

class LibraryPage extends StatefulWidget {
  LibraryPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {



  Widget doujinCardTemplate(Doujin doujin) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        children: [
          Text(doujin.dateAdded.toString(),
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.blue,
            )
          ),
          SizedBox(height: 6.0,),
          Text(doujin.cover.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    List<Doujin> doujins = [
      Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
      Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
      Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
      Doujin(dateAdded: 1023, uploadDate: 1231, cover: 'dasd', scanlator: null, rating: 3, mediaId: '1234647', id: 1234, title: null, tags: null ),
    ];
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
      body: DoujinCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
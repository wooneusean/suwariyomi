import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:suwariyomi/classes/doujin.dart';
import 'package:suwariyomi/constants.dart';
import 'package:suwariyomi/providers/doujin_provider.dart';
import 'package:suwariyomi/views/doujin/doujin_details/update_doujin_rating_dialog.dart';

import 'doujin_details_view_args.dart';

class DoujinDetailsPage extends StatefulWidget {
  final DoujinDetailsViewArgs args;

  const DoujinDetailsPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DoujinDetailsPage> createState() => _DoujinDetailsPageState();
}

class _DoujinDetailsPageState extends State<DoujinDetailsPage> {
  late Doujin doujin;
  bool isLoading = true;

  void _copyCodeToClipboard() async {
    await Clipboard.setData(
      ClipboardData(
        text: (doujin.id).toString(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied nuke code to clipboard!"),
      ),
    );
  }

  void _retrieveDoujin() {
    setState(() {
      isLoading = true;
    });
    var doujinProvider = DoujinProvider();

    doujinProvider.retrieve(widget.args.id).then((value) {
      setState(() {
        doujin = value;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveDoujin();
  }

  void _showDeleteConfirmDialog() async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete dis?'),
        content: const Text(
          'This item will be permanently deleted, and the only way to get it back is if you remember the nuke code and re-add it back in the library view.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 0),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 1),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (result == 1) {
      final doujinProvider = DoujinProvider();
      await doujinProvider.delete(doujin.id);
      Navigator.of(context).pop();
      final homePageState = Constants.HOME_KEY.currentState;
      homePageState?.retrieveDoujins();
    }
  }

  void _showUpdateRatingDialog() async {
    final result = await showDialog<int>(
      context: context,
      builder: (_) => UpdateRatingDialog(prevRating: doujin.rating.toDouble()),
    );
    if (result! >= 0) {
      final doujinProvider = DoujinProvider();
      doujin.rating = result;
      await doujinProvider.update(doujin.id, doujin);
      _retrieveDoujin();
      final homePageState = Constants.HOME_KEY.currentState;
      homePageState?.retrieveDoujins();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              doujin.getCoverUrl(),
                            ),
                          ),
                        ),
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                      ),
                      Positioned(
                        child: Container(
                          height: 96,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50),
                            ),
                          ),
                        ),
                        bottom: -1,
                        left: 0,
                        right: 0,
                      ),
                      Positioned(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 6.0,
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  doujin.getCoverUrl(),
                                ),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        bottom: 16,
                        left: MediaQuery.of(context).size.width * 0.25,
                        right: MediaQuery.of(context).size.width * 0.25,
                      )
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'added on ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: doujin.getDateAdded(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      doujin.rating.toString(),
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      doujin.id.toString(),
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: _copyCodeToClipboard,
                                    icon: FaIcon(FontAwesomeIcons.radiation),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: _showUpdateRatingDialog,
                                    icon: Icon(Icons.auto_awesome),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      print('Bookmark');
                                    },
                                    icon: Icon(Icons.bookmark_border),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 32),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Details',
                                style: Theme.of(context).textTheme.headline5?.merge(
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pages',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    doujin.numPages.toString(),
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Artist(s)',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    doujin.getArtists().join(', '),
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Language',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    doujin.getLanguages().join(', '),
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Group',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    doujin.getGroups().join(', '),
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Tags',
                                style: Theme.of(context).textTheme.headline5?.merge(
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                              ),
                            ),
                            Wrap(
                              spacing: 4.0,
                              runSpacing: -8.0,
                              children: [
                                ...doujin.getTags().map(
                                      (e) => Chip(
                                        backgroundColor: Colors.black.withAlpha(20),
                                        padding: EdgeInsets.all(8),
                                        label: Text(e ?? ''),
                                      ),
                                    ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: _showDeleteConfirmDialog,
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

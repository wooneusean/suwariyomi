import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suwariyomi/providers/doujin_provider.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_label.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_rating_slider.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_view_args.dart';
import '../../../classes/doujin.dart';

class DoujinDetailsPage extends StatefulWidget {
  final DoujinDetailsViewArgs args;

  const DoujinDetailsPage({Key? key, required this.args}) : super(key: key);

  _DoujinDetailsPageState createState() => _DoujinDetailsPageState();
}

class _DoujinDetailsPageState extends State<DoujinDetailsPage> {
  late Doujin doujin;
  bool isLoading = true;
  double _ratingSliderValue = 0;

  TextStyle _hyperlink = TextStyle(color: Colors.blue, decoration: TextDecoration.underline);

  void _retrieveDoujin() {
    setState(() {
      isLoading = true;
    });
    var doujinProvider = DoujinProvider();

    doujinProvider.retrieve(widget.args.id).then((value) {
      setState(() {
        doujin = value;
        isLoading = false;
        _ratingSliderValue = value.rating.toDouble();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveDoujin();
  }

  void _updateRating() async {
    var doujinProvider = DoujinProvider();
    doujin.rating = _ratingSliderValue.round();
    await doujinProvider.update(widget.args.id, doujin);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Saved changes to this doujin."),
      ),
    );
    widget.args.callback();
  }

  List<String?> _getArtists() {
    return doujin.tags.where((element) => element.type == "artist").map((e) => e.name).toList();
  }

  List<String?> _getTags() {
    return doujin.tags.where((element) => element.type == "tag").map((e) => e.name).toList();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doujin Details"),
        actions: [
          IconButton(
            onPressed: _updateRating,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.topCenter,
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1328,
                            child: Container(
                              height: 250,
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.network(
                                  doujin.getCoverUrl(),
                                  errorBuilder: (_, __, ___) {
                                    return Center(
                                      child: Text("No Image"),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1618,
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DoujinDetailsLabel(label: "English"),
                                  Text(
                                    doujin.title.english,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DoujinDetailsLabel(label: "Japanese"),
                                  Text(
                                    doujin.title.japanese,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DoujinDetailsLabel(label: "Pretty"),
                                  Text(
                                    doujin.title.pretty,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  DoujinDetailsLabel(label: "Artist(s)"),
                                  Wrap(
                                    children: [
                                      ..._getArtists().map(
                                        (e) => Text(
                                          e ?? '',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  DoujinDetailsLabel(label: "Nuke Code"),
                                  GestureDetector(
                                    child: Text(
                                      (doujin.id).toString(),
                                      style: _hyperlink.merge(
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onTap: _copyCodeToClipboard,
                                  ),
                                  DoujinDetailsLabel(label: "Date Added"),
                                  Text(
                                    DateTime.fromMillisecondsSinceEpoch(doujin.dateAdded).toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Tags',
                            style: Theme.of(context).textTheme.headline6?.merge(
                                  TextStyle(color: Colors.grey.shade500, fontSize: 15),
                                ),
                          ),
                          Wrap(
                            spacing: 4.0,
                            runSpacing: -8.0,
                            children: [
                              ..._getTags().map(
                                (e) => Chip(
                                  padding: EdgeInsets.all(8),
                                  label: Text(e ?? ''),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DoujinDetailsRatingSlider(
                      ratingSliderValue: _ratingSliderValue,
                      notifyRatingChanged: (double value) {
                        setState(() {
                          _ratingSliderValue = value;
                        });
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

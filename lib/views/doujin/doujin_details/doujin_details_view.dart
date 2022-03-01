import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suwariyomi/providers/doujin_provider.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_label.dart';
import 'package:suwariyomi/views/doujin/doujin_details/doujin_details_rating_slider.dart';
import '../../../classes/doujin.dart';

class DoujinDetailsPage extends StatefulWidget {
  final int doujinId;

  const DoujinDetailsPage({Key? key, required this.doujinId}) : super(key: key);

  @override
  _DoujinDetailsPageState createState() => _DoujinDetailsPageState();
}

class _DoujinDetailsPageState extends State<DoujinDetailsPage> {
  Doujin? doujin;
  bool isLoading = true;
  double _ratingSliderValue = 0;

  TextStyle _hyperlink = TextStyle(color: Colors.blue, decoration: TextDecoration.underline);

  void _retrieveDoujin() {
    setState(() {
      isLoading = true;
    });
    var doujinProvider = DoujinProvider();
    if (widget.doujinId == null) {
      Navigator.of(context).pop();
      return;
    }

    doujinProvider.retrieve(widget.doujinId).then((value) {
      setState(() {
        doujin = value;
        isLoading = false;
        _ratingSliderValue = value.rating?.toDouble() ?? 0.0;
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
    doujin?.rating = _ratingSliderValue.round();
    await doujinProvider.update(widget.doujinId, doujin!);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Saved changes to this doujin."),
      ),
    );
  }

  List<String?> _getArtists() {
    return doujin?.tags?.where((element) => element.type == "artist").map((e) => e.name).toList() ?? [];
  }

  List<String?> _getTags() {
    return doujin?.tags?.where((element) => element.type == "tag").map((e) => e.name).toList() ?? [];
  }

  void _copyCodeToClipboard() async {
    await Clipboard.setData(
      ClipboardData(
        text: (doujin?.id ?? '').toString(),
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
                                  'https://via.placeholder.com/500x500',
                                  // 'https://t.nhentai.net/galleries/${doujin?.mediaId}/cover.${doujin?.cover == 'j' ? 'jpg' : 'png'}',
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
                                  Text(doujin?.title?.english ?? ''),
                                  DoujinDetailsLabel(label: "Japanese"),
                                  Text(doujin?.title?.japanese ?? ''),
                                  DoujinDetailsLabel(label: "Pretty"),
                                  Text(doujin?.title?.pretty ?? ''),
                                  DoujinDetailsLabel(label: "Artist(s)"),
                                  Wrap(
                                    children: [
                                      ..._getArtists().map(
                                        (e) => Text(e ?? ''),
                                      ),
                                    ],
                                  ),
                                  DoujinDetailsLabel(label: "Nuke Code"),
                                  GestureDetector(
                                    child: Text(
                                      (doujin?.id ?? '').toString(),
                                      style: _hyperlink,
                                    ),
                                    onTap: _copyCodeToClipboard,
                                  ),
                                  DoujinDetailsLabel(label: "Date Added"),
                                  Text(
                                    DateTime.fromMillisecondsSinceEpoch(doujin?.dateAdded ?? 0).toString(),
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

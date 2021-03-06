import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

int integerValueOf(dynamic value) {
  if (value is double) {
    return value.round();
  } else if (value is String) {
    return int.parse(value);
  } else {
    return value;
  }
}

class Doujin {
  late int dateAdded;
  late String cover;
  late String scanlator;
  late int rating;
  late String mediaId;
  late int id;
  late Title title;
  late List<Tag> tags;
  late int uploadDate;
  late int numPages;
  late bool isBookmarked;

  Doujin({
    required this.dateAdded,
    required this.cover,
    required this.scanlator,
    required this.rating,
    required this.mediaId,
    required this.id,
    required this.title,
    required this.tags,
    required this.uploadDate,
    required this.numPages,
    required this.isBookmarked,
  });

  Doujin.fromJson(Map<dynamic, dynamic> json) {
    dateAdded = json['date_added'] ?? DateTime.now().millisecondsSinceEpoch;
    cover = json['images'] != null
        ? json['images']['cover']['t']
        : json['cover'] != null
            ? json['cover']
            : null;
    scanlator = json['scanlator'];
    rating = json['rating'] ?? 0;
    mediaId = json['media_id'].toString();
    id = integerValueOf(json['id']);
    title = new Title.fromJson(json['title']);
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    uploadDate = json['upload_date'];
    numPages = json['num_pages'] ?? 0;
    isBookmarked = json['is_bookmarked'] ?? false;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['date_added'] = this.dateAdded;
    data['cover'] = this.cover;
    data['scanlator'] = this.scanlator;
    data['rating'] = this.rating;
    data['media_id'] = this.mediaId;
    data['id'] = this.id;
    data['title'] = this.title.toJson();
    data['tags'] = this.tags.map((v) => v.toJson()).toList();
    data['upload_date'] = this.uploadDate;
    data['num_pages'] = this.numPages;
    data['is_bookmarked'] = this.isBookmarked;
    return data;
  }

  String getCoverUrl() {
    return kDebugMode
        ? 'https://via.placeholder.com/250x350'
        : 'https://t.nhentai.net/galleries/$mediaId/cover.${cover == 'j' ? 'jpg' : 'png'}';
  }

  String getDateAdded() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(DateTime.fromMillisecondsSinceEpoch(dateAdded));
    return formatted;
  }

  List<String?> getArtists() {
    return tags.where((element) => element.type == "artist").map((e) => e.name).toList();
  }

  List<String?> getTags() {
    return tags.where((element) => element.type == "tag").map((e) => e.name).toList();
  }

  List<String> getGroups() {
    return tags.where((element) => element.type == "group").map((e) => e.name).toList();
  }

  List<String> getLanguages() {
    return tags.where((element) => element.type == "language").map((e) => e.name).toList();
  }

  @override
  String toString() {
    return 'Doujin{'
        '\n\tdateAdded: $dateAdded, '
        '\n\tcover: $cover, '
        '\n\tscanlator: $scanlator, '
        '\n\trating: $rating, '
        '\n\tmediaId: $mediaId, '
        '\n\tid: $id, '
        '\n\ttitle: $title, '
        '\n\ttags: $tags, '
        '\n\tuploadDate: $uploadDate'
        '\n\tpages: $numPages'
        '\n}';
  }
}

class Title {
  late String pretty;
  late String japanese;
  late String english;

  Title({required this.pretty, required this.japanese, required this.english});

  Title.fromJson(Map<dynamic, dynamic> json) {
    pretty = json['pretty'];
    japanese = json['japanese'];
    english = json['english'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['pretty'] = this.pretty;
    data['japanese'] = this.japanese;
    data['english'] = this.english;
    return data;
  }

  @override
  String toString() {
    return '$pretty';
  }
}

class Tag {
  late String name;
  late String type;

  Tag({required this.name, required this.type});

  Tag.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }

  @override
  String toString() {
    return '$name';
  }
}

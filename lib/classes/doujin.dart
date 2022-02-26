class Doujin {
  int? dateAdded;
  String? cover;
  String? scanlator;
  int? rating;
  String? mediaId;
  int? id;
  Title? title;
  List<Tag>? tags;
  int? uploadDate;

  Doujin(
      {this.dateAdded,
      this.cover,
      this.scanlator,
      this.rating,
      this.mediaId,
      this.id,
      this.title,
      this.tags,
      this.uploadDate});

  Doujin.fromJson(Map<dynamic, dynamic> json) {
    dateAdded = json['date_added'];
    cover = json['images'] != null
        ? json['images']['cover']['t']
        : json['cover'] != null
            ? json['cover']
            : null;
    scanlator = json['scanlator'];
    rating = json['rating'];
    mediaId = json['media_id'];
    id = json['id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(new Tag.fromJson(v));
      });
    }
    uploadDate = json['upload_date'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['date_added'] = this.dateAdded;
    data['cover'] = this.cover;
    data['scanlator'] = this.scanlator;
    data['rating'] = this.rating;
    data['media_id'] = this.mediaId;
    data['id'] = this.id;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['upload_date'] = this.uploadDate;
    return data;
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
        '\n}';
  }
}

class Image {
  String? t;

  Image({this.t});

  Image.fromJson(Map<dynamic, dynamic> json) {
    t = json['t'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['t'] = this.t;
    return data;
  }
}

class Title {
  String? pretty;
  String? japanese;
  String? english;

  Title({this.pretty, this.japanese, this.english});

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
  String? name;
  String? type;

  Tag({this.name, this.type});

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

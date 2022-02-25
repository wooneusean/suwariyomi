class Doujin {
  int? dateAdded;
  Images? images;
  String? scanlator;
  int? numPages;
  int? rating;
  String? mediaId;
  int? id;
  int? numFavorites;
  Title? title;
  List<Tags>? tags;
  int? uploadDate;

  Doujin(
      {this.dateAdded,
      this.images,
      this.scanlator,
      this.numPages,
      this.rating,
      this.mediaId,
      this.id,
      this.numFavorites,
      this.title,
      this.tags,
      this.uploadDate});

  Doujin.fromJson(Map<dynamic, dynamic> json) {
    dateAdded = json['date_added'];
    images = json['images'] != null ? new Images.fromJson(json['images']) : null;
    scanlator = json['scanlator'];
    numPages = json['num_pages'];
    rating = json['rating'];
    mediaId = json['media_id'];
    id = json['id'];
    numFavorites = json['num_favorites'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    uploadDate = json['upload_date'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['date_added'] = this.dateAdded;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    data['scanlator'] = this.scanlator;
    data['num_pages'] = this.numPages;
    data['rating'] = this.rating;
    data['media_id'] = this.mediaId;
    data['id'] = this.id;
    data['num_favorites'] = this.numFavorites;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['upload_date'] = this.uploadDate;
    return data;
  }
}

class Images {
  Image? cover;
  Image? thumbnail;
  List<Image>? pages;

  Images({this.cover, this.thumbnail, this.pages});

  Images.fromJson(Map<dynamic, dynamic> json) {
    cover = json['cover'] != null ? new Image.fromJson(json['cover']) : null;
    thumbnail = json['thumbnail'] != null ? new Image.fromJson(json['thumbnail']) : null;
    if (json['pages'] != null) {
      pages = <Image>[];
      json['pages'].forEach((v) {
        pages!.add(new Image.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.cover != null) {
      data['cover'] = this.cover!.toJson();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? t;
  int? w;
  int? h;

  Image({this.t, this.w, this.h});

  Image.fromJson(Map<dynamic, dynamic> json) {
    t = json['t'];
    w = json['w'];
    h = json['h'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['t'] = this.t;
    data['w'] = this.w;
    data['h'] = this.h;
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
}

class Tags {
  int? count;
  String? name;
  int? id;
  String? type;
  String? url;

  Tags({this.count, this.name, this.id, this.type, this.url});

  Tags.fromJson(Map<dynamic, dynamic> json) {
    count = json['count'];
    name = json['name'];
    id = json['id'];
    type = json['type'];
    url = json['url'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

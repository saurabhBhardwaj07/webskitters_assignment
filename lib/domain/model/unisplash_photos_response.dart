class UniSplashPhoto {
  String? id;
  String? color;
  String? blurHash;
  String? description;
  Urls? urls;
  Links? links;
  int? likes;
  bool? likedByUser;

  UniSplashPhoto({
    this.id,
    this.color,
    this.blurHash,
    this.description,
    this.urls,
    this.links,
    this.likes,
    this.likedByUser,
  });

  UniSplashPhoto.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }

    if (json["color"] is String) {
      color = json["color"];
    }
    if (json["blur_hash"] is String) {
      blurHash = json["blur_hash"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["urls"] is Map) {
      urls = json["urls"] == null ? null : Urls.fromJson(json["urls"]);
    }
    if (json["links"] is Map) {
      links = json["links"] == null ? null : Links.fromJson(json["links"]);
    }
    if (json["likes"] is int) {
      likes = json["likes"];
    }
    if (json["liked_by_user"] is bool) {
      likedByUser = json["liked_by_user"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["color"] = color;
    _data["blur_hash"] = blurHash;
    _data["description"] = description;
    if (urls != null) {
      _data["urls"] = urls?.toJson();
    }
    if (links != null) {
      _data["links"] = links?.toJson();
    }
    _data["likes"] = likes;
    _data["liked_by_user"] = likedByUser;
    return _data;
  }
}

class Links {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  Links({this.self, this.html, this.download, this.downloadLocation});

  Links.fromJson(Map<String, dynamic> json) {
    if (json["self"] is String) {
      self = json["self"];
    }
    if (json["html"] is String) {
      html = json["html"];
    }
    if (json["download"] is String) {
      download = json["download"];
    }
    if (json["download_location"] is String) {
      downloadLocation = json["download_location"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["self"] = self;
    _data["html"] = html;
    _data["download"] = download;
    _data["download_location"] = downloadLocation;
    return _data;
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls(
      {this.raw,
      this.full,
      this.regular,
      this.small,
      this.thumb,
      this.smallS3});

  Urls.fromJson(Map<String, dynamic> json) {
    if (json["raw"] is String) {
      raw = json["raw"];
    }
    if (json["full"] is String) {
      full = json["full"];
    }
    if (json["regular"] is String) {
      regular = json["regular"];
    }
    if (json["small"] is String) {
      small = json["small"];
    }
    if (json["thumb"] is String) {
      thumb = json["thumb"];
    }
    if (json["small_s3"] is String) {
      smallS3 = json["small_s3"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["raw"] = raw;
    _data["full"] = full;
    _data["regular"] = regular;
    _data["small"] = small;
    _data["thumb"] = thumb;
    _data["small_s3"] = smallS3;
    return _data;
  }
}

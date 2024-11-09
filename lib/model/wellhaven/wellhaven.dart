// ignore_for_file: unnecessary_new, prefer_collection_literals

class Wallhaven {
  List<Data>? data;
  Meta? meta;

  Wallhaven({this.data, this.meta});

  Wallhaven.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? url;
  String? shortUrl;
  int? views;
  int? favorites;
  String? source;
  String? purity;
  String? category;
  int? dimensionX;
  int? dimensionY;
  String? resolution;
  String? ratio;
  int? fileSize;
  String? fileType;
  String? createdAt;
  List<String>? colors;
  String? path;
  Thumbs? thumbs;

  Data(
      {this.id,
      this.url,
      this.shortUrl,
      this.views,
      this.favorites,
      this.source,
      this.purity,
      this.category,
      this.dimensionX,
      this.dimensionY,
      this.resolution,
      this.ratio,
      this.fileSize,
      this.fileType,
      this.createdAt,
      this.colors,
      this.path,
      this.thumbs});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    shortUrl = json['short_url'];
    views = json['views'];
    favorites = json['favorites'];
    source = json['source'];
    purity = json['purity'];
    category = json['category'];
    dimensionX = json['dimension_x'];
    dimensionY = json['dimension_y'];
    resolution = json['resolution'];
    ratio = json['ratio'];
    fileSize = json['file_size'];
    fileType = json['file_type'];
    createdAt = json['created_at'];
    colors = json['colors'].cast<String>();
    path = json['path'];
    thumbs =
        json['thumbs'] != null ? new Thumbs.fromJson(json['thumbs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['short_url'] = this.shortUrl;
    data['views'] = this.views;
    data['favorites'] = this.favorites;
    data['source'] = this.source;
    data['purity'] = this.purity;
    data['category'] = this.category;
    data['dimension_x'] = this.dimensionX;
    data['dimension_y'] = this.dimensionY;
    data['resolution'] = this.resolution;
    data['ratio'] = this.ratio;
    data['file_size'] = this.fileSize;
    data['file_type'] = this.fileType;
    data['created_at'] = this.createdAt;
    data['colors'] = this.colors;
    data['path'] = this.path;
    if (this.thumbs != null) {
      data['thumbs'] = this.thumbs!.toJson();
    }
    return data;
  }
}

class Thumbs {
  String? large;
  String? original;
  String? small;

  Thumbs({this.large, this.original, this.small});

  Thumbs.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    original = json['original'];
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['large'] = this.large;
    data['original'] = this.original;
    data['small'] = this.small;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? lastPage;
  int? perPage; // Change this to int to match the API response
  int? total;
  String? query;
  String? seed;

  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.query,
    this.seed,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] is String
        ? int.tryParse(json['current_page']) // Parse if it's a string
        : json['current_page'] as int?;

    lastPage = json['last_page'] is String
        ? int.tryParse(json['last_page'])
        : json['last_page'] as int?;

    perPage = json['per_page'] is String
        ? int.tryParse(json['per_page'])
        : json['per_page'] as int?;

    total = json['total'] is String
        ? int.tryParse(json['total'])
        : json['total'] as int?;

    query = json['query'];
    seed = json['seed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['query'] = this.query;
    data['seed'] = this.seed;
    return data;
  }
}

class Reddit {
  String kind;
  Data data;

  Reddit({this.kind, this.data});

  Reddit.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String modhash;
  int dist;
  List<Children> children;

  Data({this.modhash, this.children, this.dist});

  Data.fromJson(Map<String, dynamic> json) {
    modhash = json['modhash'];
    dist = json["dist"];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }
}

class Children {
  String kind;
  Post post;

  Children({this.kind, this.post});

  Children.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    post = json['data'] != null ? new Post.fromJson(json['data']) : null;
  }
}

class Post {
  String subreddit;
  String title;
  String name;
  String subredditType;
  String postHint;
  String id;
  bool isVideo;
  Preview preview;
  SecureMedia secureMedia;

  Post(
      {this.subreddit,
      this.title,
      this.name,
      this.subredditType,
      this.postHint,
      this.id,
      this.isVideo,
      this.preview,
      this.secureMedia});

  Post.fromJson(Map<String, dynamic> json) {
    subreddit = json['subreddit'];
    title = json['title'];
    name = json['name'];
    subredditType = json['subreddit_type'];
    postHint = json['post_hint'];
    id = json['id'];
    isVideo = json['is_video'];
    preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
    secureMedia = json['secure_media'] != null
        ? new SecureMedia.fromJson(json['secure_media'])
        : null;
  }
}

class Preview {
  bool enabled;
  List<Images> images;

  Preview({this.enabled, this.images});

  Preview.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }
}

class Images {
  String id;
  Source source;

  Images({this.id, this.source});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source =
        json['source'] != null ? new Source.fromJson(json['source']) : null;
  }
}

class Source {
  String url;
  int width;
  int height;

  Source({this.url, this.width, this.height});

  Source.fromJson(Map<String, dynamic> json) {
    url = json['url'].replaceAll("amp;", "");
    width = json['width'];
    height = json['height'];
  }
}

class SecureMedia {
  RedditVideo redditVideo;

  SecureMedia({this.redditVideo});

  SecureMedia.fromJson(Map<String, dynamic> json) {
    redditVideo = json['reddit_video'] != null
        ? new RedditVideo.fromJson(json['reddit_video'])
        : null;
  }
}

class RedditVideo {
  String fallbackUrl;
  int width;
  int height;

  RedditVideo({this.fallbackUrl, this.width, this.height});

  RedditVideo.fromJson(Map<String, dynamic> json) {
    fallbackUrl = json['fallback_url'];
    width = json['width'];
    height = json['height'];
  }
}

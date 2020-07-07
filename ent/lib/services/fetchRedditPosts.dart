import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ent/models/redditModel.dart';
import "dart:async";

class FetchRedditPosts {
  Future<List<Source>> getRedditImageSource(String reddit) async {
    try {
      final res = await http.get("https://www.reddit.com/r/${reddit}.json");

      print(res.body);

      List<Source> _sources = [];

      if (res.statusCode == 200) {
        Reddit _data = Reddit.fromJson(json.decode(res.body));
        print(_data.data.children);
        _data.data.children.forEach((child) {
          print(child.kind);
          if (child.post.postHint == "image") {
            child.post.preview.images.forEach((image) {
              print(image.source.url);
              _sources.add(image.source);
            });
          }
        });
        return _sources;
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Source>> getAllRedditsImagesSources(
      List<String> subreddits) async {
    List<Source> temp;
    List<Source> _allRedditsImagesSources = [];
    for (String subreddit in subreddits) {
      temp = await getRedditImageSource(subreddit);
      for (Source source in temp) {
        _allRedditsImagesSources.add(source);
      }
    }
    return _allRedditsImagesSources;
  }
}

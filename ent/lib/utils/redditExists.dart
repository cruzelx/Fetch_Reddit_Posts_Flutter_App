import 'dart:async';
import 'package:ent/models/redditModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> doesSubredditExist(String subreddit) async {
  try {
    final res = await http.get("https://www.reddit.com/r/$subreddit.json");
    if (res.statusCode == 200) {
      print("inside check subreddit");
      Reddit subreddit = Reddit.fromJson(json.decode(res.body));
      print(subreddit.data.dist != 0);
      return subreddit.data.dist != 0;
    }
    return false;
  } catch (e) {
    return false;
  }
}

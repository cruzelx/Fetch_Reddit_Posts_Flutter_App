import 'package:ent/models/redditModel.dart';
import 'package:ent/utils/sharedPrefData.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ent/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedditsModel extends ChangeNotifier {
  RedditsModel() {
    transactionWithSP();
  }

  final String BASE_URL = "https://www.reddit.com/";

  DataFetchState _dataFetchState;

  List<String> _subreddits = [];
  List<Post> _imagePosts = [];
  List<Post> _videoPosts = [];

  List<String> get getSubreddits => _subreddits;
  List<Post> get imagePosts => _imagePosts;
  List<Post> get videoPosts => _videoPosts;
  DataFetchState get dataFetchState => _dataFetchState;

  getPosts(String subreddit) async {
    // _dataFetchState = DataFetchState.IS_LOADING;
    notifyListeners();
    try {
      final response = await http.get("$BASE_URL/r/$subreddit.json");

      if (response.statusCode == 200) {
        print(response.body);
        Reddit reddit = Reddit.fromJson(json.decode(response.body));
        print(reddit);
        reddit.data.children.forEach((child) {
          if (child.post.postHint == "image") {
            _imagePosts.add(child.post);
          }
          if (child.post.isVideo) {
            _videoPosts.add(child.post);
          }
        });
        print("postsLength: " + _imagePosts.length.toString());
        // _dataFetchState = DataFetchState.IS_LOADED;

        notifyListeners();
      } else {
        _dataFetchState = DataFetchState.ERROR_ENCOUNTERED;
        notifyListeners();
      }
    } catch (e) {
      _dataFetchState = DataFetchState.ERROR_ENCOUNTERED;
      print("error");
      notifyListeners();
    }
  }

  Future<void> transactionWithSP() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _subreddits = prefs.getStringList("subreddits") ?? [];
    _dataFetchState = DataFetchState.IS_LOADING;
    _imagePosts = [];
    _videoPosts = [];
    notifyListeners();
    fetchSubredditsFromSP().then((value) {
      _subreddits = value ?? [];
      _subreddits.forEach((subreddit) {
        getPosts(subreddit);
      });
      _dataFetchState = _imagePosts.length == 0
          ? DataFetchState.NO_IMAGE_DATA
          : DataFetchState.IS_LOADED;

      notifyListeners();
    });
  }

  addSubreddit(reddit) {
    _subreddits.add(reddit);
    addSubredditToSP(reddit);
    transactionWithSP();
    notifyListeners();
  }

  removeSubreddit(reddit) {
    _subreddits.remove(reddit);
    removeSubredditFromSP(reddit);
    transactionWithSP();
    notifyListeners();
  }

  clearAllSubreddits() {
    _subreddits = [];
    clearAllSubredditsFromSP();
    notifyListeners();
  }
}

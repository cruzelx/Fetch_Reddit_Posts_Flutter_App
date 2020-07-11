import 'dart:async';

import 'package:ent/errors.dart/serviceErrors.dart';
import 'package:ent/models/redditModel.dart';
import 'package:ent/services/connectivityService.dart';
import 'package:ent/utils/sharedPrefData.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ent/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class RedditsModel extends ChangeNotifier {
  RedditsModel() {
    transactionWithSP();
  }

  final String BASE_URL = "https://www.reddit.com/";

  ImageDataFetchState _imageDataFetchState;
  VideoDataFetchState _videoDataFetchState;

  List<String> _subreddits = [];
  List<Post> _imagePosts = [];
  List<Post> _videoPosts = [];

  List<String> get getSubreddits => _subreddits;
  List<Post> get imagePosts => _imagePosts;
  List<Post> get videoPosts => _videoPosts;

  ImageDataFetchState get imageDataFetchState => _imageDataFetchState;
  VideoDataFetchState get videoDataFetchState => _videoDataFetchState;

  Future<void> getPosts(List<String> subreddits) async {
    try {
      for (String subreddit in subreddits) {
        try {
          final response = await http.get("$BASE_URL/r/$subreddit.json");

          if (response.statusCode == 200) {
            Reddit reddit = Reddit.fromJson(json.decode(response.body));
            reddit.data.children.forEach((child) {
              if (child.post.postHint == "image") {
                _imagePosts.insert(0, child.post);
              }
              if (child.post.isVideo) {
                _videoPosts.insert(0, child.post);
              }

              if (child.post.postHint == "rich:video" &&
                  child.post.preview.redditVideoPreview != null) {
                print(child.post.preview.redditVideoPreview.fallbackUrl);
                _videoPosts.insert(0, child.post);
              }
            });
          } else {}
        } catch (e) {
          throw e;
        }
      }
    } catch (e) {
      _imageDataFetchState =
          ImageDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_IMAGE_DATA;
      _videoDataFetchState =
          VideoDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_VIDEO_DATA;
      notifyListeners();
    }
  }

  transactionWithSP() async {
    try {
      _imagePosts = [];
      _videoPosts = [];

      _imageDataFetchState = ImageDataFetchState.IS_IMAGE_DATA_LOADING;
      _videoDataFetchState = VideoDataFetchState.IS_VIDEO_DATA_LOADING;

      notifyListeners();

      final res = await fetchSubredditsFromSP();

      _subreddits = res;

      getPosts(res).then((value) {
        _imageDataFetchState = _imagePosts.isNotEmpty
            ? ImageDataFetchState.IS_IMAGE_DATA_LOADED
            : ImageDataFetchState.NO_IMAGE_DATA;

        _videoDataFetchState = _videoPosts.isNotEmpty
            ? VideoDataFetchState.IS_VIDEO_DATA_LOADED
            : VideoDataFetchState.NO_VIDEO_DATA;

        notifyListeners();
      }).catchError((e) {
        _imageDataFetchState =
            ImageDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_IMAGE_DATA;
        _videoDataFetchState =
            VideoDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_VIDEO_DATA;
        notifyListeners();
      });
    } catch (e) {
      _imageDataFetchState =
          ImageDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_IMAGE_DATA;
      _videoDataFetchState =
          VideoDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_VIDEO_DATA;
      notifyListeners();
    }
  }

  addSubreddit(subreddit) {
    _subreddits.add(subreddit);
    addSubredditToSP(subreddit).then((value) => transactionWithSP());
  }

  removeSubreddit(subreddit) {
    _subreddits.remove(subreddit);
    removeSubredditFromSP(subreddit).whenComplete(() => transactionWithSP());
  }

  clearAllSubreddits() {
    _subreddits.clear();
    clearAllSubredditsFromSP().whenComplete(() => transactionWithSP());
  }
}

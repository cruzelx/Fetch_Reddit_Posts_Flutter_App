import 'package:shared_preferences/shared_preferences.dart';

Future<void> addSubredditToSP(String subreddit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> subredditList = prefs.getStringList("subreddits") ?? [];
  if (subredditList.contains(subreddit)) return;
  subredditList.add(subreddit);
  prefs.setStringList("subreddits", subredditList);
}

Future<List<String>> fetchSubredditsFromSP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList("subreddits") ?? <String>[];
}

Future<void> removeSubredditFromSP(String subreddit) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> subredditList = prefs.getStringList("subreddits") ?? [];
  subredditList.remove(subreddit);
  prefs.setStringList("subreddits", subredditList);
}

Future<void> clearAllSubredditsFromSP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("subreddits");
}

setThemeModeToSP(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("theme", value);
}

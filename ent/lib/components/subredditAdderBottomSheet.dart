import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/utils/redditExists.dart';
import 'package:ent/utils/sharedPrefData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void addSubRedditButtomModelSheet(context) {
  TextEditingController subredditAdder = TextEditingController();
  // final reddit = Provider.of<RedditsModel>(context, listen: false);
  final controller = showBottomSheet(
      elevation: 0.0,
      context: context,
      builder: (BuildContext context) {
        return Container(
            margin: EdgeInsets.all(10.0),
            height: 160.0,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextField(
                          controller: subredditAdder,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: "Enter r/SubReddit",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Color(0xffe9e9e9)),
                        ),
                        RaisedButton(
                          textColor: Colors.white,
                          color: Colors.redAccent,
                          onPressed: () async {
                            String subreddit = subredditAdder.text.toString();
                            print("Inside Button");
                            final doesSubRedditExist =
                                await doesSubredditExist(subreddit);
                            doesSubRedditExist
                                ? Provider.of<RedditsModel>(context,
                                        listen: false)
                                    .addSubreddit(subreddit)
                                // ignore: unnecessary_statements
                                : null;
                            // doesSubredditExist(subreddit).then((bool value) =>
                            //     value
                            //         ? Provider.of<RedditsModel>(context,
                            //                 listen: false)
                            //             .addReddit(subreddit)
                            //         : null);
                            subredditAdder.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Add r/SubReddit"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
      });
}

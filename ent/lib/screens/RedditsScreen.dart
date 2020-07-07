import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/components/subredditAdderBottomSheet.dart';
import 'package:ent/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ent/components/subredditButtons.dart';

class RedditsScreen extends StatefulWidget {
  @override
  _RedditsScreenState createState() => _RedditsScreenState();
}

class _RedditsScreenState extends State<RedditsScreen> {
  bool _showFab = true;
  TextEditingController _addSubRedditTextController;
  List<String> _subreddits;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addSubRedditTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addSubRedditTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Main Thread");
    return SafeArea(
      child: Scaffold(
          floatingActionButton: _fab(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Stack(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 15.0, left: 25.0, right: 25.0, bottom: 70.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: 10.0,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    for (String subreddit
                        in Provider.of<RedditsModel>(context).getSubreddits)
                      SubRedditButton(
                        subreddit: subreddit,
                        gotoSubreddit: () {},
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
            )
          ])),
    );
  }
}

Widget _fab(context) {
  return FloatingActionButton.extended(
    onPressed: () {
      addSubRedditButtomModelSheet(context);
    },
    label: Text("r/Subreddit"),
    icon: Icon(Icons.add),
    backgroundColor: Colors.redAccent,
  );
}

import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/utils/randomColorGenerator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubRedditButton extends StatefulWidget {
  final String subreddit;
  final Function gotoSubreddit;
  SubRedditButton({Key key, this.gotoSubreddit, this.subreddit})
      : super(key: key);
  @override
  _SubRedditButtonState createState() => _SubRedditButtonState();
}

class _SubRedditButtonState extends State<SubRedditButton> {
  bool _showCloseButton = false;
  @override
  Widget build(BuildContext context) {
    final reddit = Provider.of<RedditsModel>(context);
    return RaisedButton(
      onLongPress: () {
        setState(() {
          _showCloseButton = true;
        });
      },
      elevation: 5.0,
      textColor: Colors.white,
      onPressed: widget.gotoSubreddit,
      child: _showCloseButton
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete, size: 20.0),
                    onPressed: () {
                      reddit.removeSubreddit(widget.subreddit);
                      reddit.transactionWithSP();
                    }),
                IconButton(
                    icon: Icon(Icons.close, size: 20.0),
                    onPressed: () {
                      setState(() {
                        _showCloseButton = false;
                      });
                    }),
              ],
            )
          : Text("r/${widget.subreddit}", style: TextStyle(fontSize: 12.0)),
      color: generateRandomColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

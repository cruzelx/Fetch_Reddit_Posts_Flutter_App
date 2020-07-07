import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/screens/ImagesScreen.dart';
import 'package:ent/screens/RedditsScreen.dart';
import 'package:ent/screens/VideosScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _pageViewController = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: <Widget>[
          RedditsScreen(),
          ImagesScreen(),
          VideosScreen(),
        ],
      ),
    );
  }
}

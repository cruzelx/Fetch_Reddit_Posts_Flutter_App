import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/bloc/themeProvider.dart';
import 'package:ent/constants/themes.dart';
import 'package:ent/screens/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(RedditFetcher());
}

class RedditFetcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => RedditsModel()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      print(value.getString("theme"));
      Provider.of<ThemeProvider>(context, listen: false)
          .setThemeMode(value.getString("theme"));
    });
    return MaterialApp(
      title: "Ent App",
      home: MainPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LandingScreen();
  }
}

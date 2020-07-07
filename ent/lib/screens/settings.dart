import 'dart:io';
import 'dart:async';

import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/bloc/themeProvider.dart';
import 'package:ent/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _cacheSize = "0 MB";

  _clearCache() async {
    try {
      await DefaultCacheManager().emptyCache();
    } catch (e) {
      print(e);
    }
    _getCacheSize();
  }

  _getCacheSize() async {
    final dir = new Directory(await DefaultCacheManager().getFilePath());
    if (dir.existsSync()) {
      FileStat _fileStat = dir.statSync();
      _cacheSize = "${_fileStat.size / 1024.0} MB";
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCacheSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final res = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Settings")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Dark Mode"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete_sweep),
                title: Text("Clear Cache"),
                subtitle: Text("Cache Size: ${_cacheSize}"),
                onTap: _clearCache,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.clear_all),
                title: Text("Clear App Data"),
                onTap: () {
                  Provider.of<RedditsModel>(context, listen: false)
                      .clearAllSubreddits();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

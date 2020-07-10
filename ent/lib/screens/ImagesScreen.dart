import 'package:cached_network_image/cached_network_image.dart';
import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/components/imageShimmer.dart';
import 'package:ent/constants/enums.dart';
import 'package:ent/models/redditModel.dart';
import 'package:ent/services/fetchRedditPosts.dart';
import 'package:ent/utils/sharedPrefData.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class ImagesScreen extends StatefulWidget {
  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final res = Provider.of<RedditsModel>(context);
    final posts = res.imagePosts;
    print(res.imageDataFetchState);
    return SafeArea(
      child: Scaffold(
          body: res.imageDataFetchState ==
                  ImageDataFetchState
                      .ERROR_ENCOUNTERED_WHILE_FETCHING_IMAGE_DATA
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.sentiment_dissatisfied, size: 100.0),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Error Fetching Data"),
                      SizedBox(height: 15.0),
                      RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                          onPressed: () {
                            res.transactionWithSP();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.refresh),
                              SizedBox(width: 10.0),
                              Text("Refresh")
                            ],
                          )),
                    ],
                  ),
                )
              : res.imageDataFetchState ==
                      ImageDataFetchState.IS_IMAGE_DATA_LOADED
                  ? ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final source = posts[index].preview.images[0].source;
                        return Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              placeholder: (context, url) =>
                                  ImageLoadingShimmer(
                                      height: (source.height / source.width) *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width -
                                          16.0),
                              errorWidget: (_, __, ___) => Center(
                                  child: Text("Error Fetching Image Data")),
                              imageUrl: "${source.url}",
                              imageBuilder: (context, imageProvider) =>
                                  AspectRatio(
                                aspectRatio: source.width / source.height,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain)),
                                ),
                              ),
                            ),
                          ),
                        ]);
                      })
                  : res.imageDataFetchState ==
                          ImageDataFetchState.IS_IMAGE_DATA_LOADING
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(height: 20.0),
                            Text("Loading"),
                          ],
                        ))
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.sentiment_neutral, size: 100),
                            SizedBox(height: 20),
                            Text("No Data Found")
                          ],
                        ))),
    );
  }
}

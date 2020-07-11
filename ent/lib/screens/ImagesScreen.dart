import 'package:cached_network_image/cached_network_image.dart';
import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/components/fetchStatusWidgets.dart';
import 'package:ent/components/imageShimmer.dart';
import 'package:ent/constants/enums.dart';
import 'package:ent/models/redditModel.dart';
import 'package:ent/services/fetchRedditPosts.dart';
import 'package:ent/utils/sharedPrefData.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class ImagesScreen extends StatefulWidget {
  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
              ? errorFetchingData(res)
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
                                          20.0),
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
                      ? dataLoading()
                      : noDataFound()),
    );
  }
}

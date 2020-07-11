import 'package:ent/bloc/redditsProvider.dart';
import 'package:ent/components/fetchStatusWidgets.dart';
import 'package:ent/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:ent/components/videoPlayer.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final res = Provider.of<RedditsModel>(context);
    final posts = res.videoPosts;
    return SafeArea(
        child: res.videoDataFetchState ==
                VideoDataFetchState.ERROR_ENCOUNTERED_WHILE_FETCHING_VIDEO_DATA
            ? errorFetchingData(res)
            : res.videoDataFetchState ==
                    VideoDataFetchState.IS_VIDEO_DATA_LOADED
                ? PageView.builder(
                    itemCount: posts.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var video;
                      if (posts[index].isVideo) {
                        video = posts[index].secureMedia.redditVideo;
                      } else {
                        video = posts[index].preview.redditVideoPreview;
                      }
                      return Container(
                        child: PlayVideo(
                          videoUrl: video.fallbackUrl,
                          height: video.height.toDouble(),
                          width: video.width.toDouble(),
                        ),
                      );
                    })
                : res.videoDataFetchState ==
                        VideoDataFetchState.IS_VIDEO_DATA_LOADING
                    ? dataLoading()
                    : noDataFound());
  }
}

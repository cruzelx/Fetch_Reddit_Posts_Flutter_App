import 'package:ent/bloc/redditsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:ent/components/videoPlayer.dart';

class VideosScreen extends StatefulWidget {
  @override
  _VideosScreenState createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    final res = Provider.of<RedditsModel>(context);
    final posts = res.videoPosts;
    return SafeArea(
      child: PageView.builder(
          itemCount: posts.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final video = posts[index].secureMedia.redditVideo;
            return Container(
              child: PlayVideo(
                videoUrl: video.fallbackUrl,
                height: video.height.toDouble(),
                width: video.width.toDouble(),
              ),
            );
          }),
    );
  }
}

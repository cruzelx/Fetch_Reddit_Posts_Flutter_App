import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ImageLoadingShimmer extends StatelessWidget {
  final double height;
  ImageLoadingShimmer({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer(
        child: Card(
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(15.0)),
          ),
        ),
        gradient: LinearGradient(colors: [Colors.grey[300], Colors.black54]));
  }
}

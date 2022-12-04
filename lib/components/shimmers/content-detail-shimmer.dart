import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

var shimmerBoxDecoration =
    BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black);

class ContentDetailShimmer extends StatelessWidget {
  const ContentDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: shimmerBoxDecoration,
                ),
              ),
              Divider(height: 20),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: shimmerBoxDecoration,
                ),
              ),
              Divider(height: 20),
              Flexible(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: shimmerBoxDecoration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

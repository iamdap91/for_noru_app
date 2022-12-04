import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

var shimmerBoxDecoration =
    BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black);

class ContentListShimmer extends StatelessWidget {
  const ContentListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 100,
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

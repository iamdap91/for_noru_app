import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetail extends StatelessWidget {
  const ImageDetail({
    Key? key,
    required String this.imageUrl,
    required String this.tag,
  }) : super(key: key);

  final tag;
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: PhotoView(
        imageProvider: NetworkImage(imageUrl),
      ),
    );
  }
}

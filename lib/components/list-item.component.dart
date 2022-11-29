import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required String this.thumbnail,
    required String this.name,
    List<String>? this.tags,
    required List<String> this.categories,
    required String this.distance,
  }) : super(key: key);

  final thumbnail;
  final name;
  final tags;
  final categories;
  final distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 100,
                child: thumbnail.length > 0
                    ? Image.network(thumbnail)
                    : Image.asset('assets/eraser.png'),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                  Text(
                    categories.join(','),
                    style: const TextStyle(fontSize: 10.0),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text(
                    tags.join(','),
                    style: const TextStyle(fontSize: 10.0),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text(
                    distance,
                    style: const TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

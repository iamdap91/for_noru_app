import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required String this.thumbnail,
    required String this.title,
    required List<String> this.tags,
    required List<String> this.categories,
  }) : super(key: key);

  final thumbnail;
  final title;
  final tags;
  final categories;

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
                child: Image.network(thumbnail),
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
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
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

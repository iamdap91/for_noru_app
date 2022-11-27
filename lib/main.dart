import 'package:flutter/material.dart';
import 'package:for_noru_app/components/item-detail.component.dart';
import 'package:for_noru_app/utils/get-position.dart';

import 'components/list-item.component.dart';

const List<Widget> fruits = <Widget>[
  Text('전체'),
  Text('카페'),
  Text('음식점'),
];
final List<bool> _selectedFruits = <bool>[true, false, false];

void main() {
  runApp(
    MaterialApp(
      home: NoruApp(),
    ),
  );
}

class NoruApp extends StatefulWidget {
  const NoruApp({Key? key}) : super(key: key);

  @override
  State<NoruApp> createState() => _NoruAppState();
}

class _NoruAppState extends State<NoruApp> {
  List<Map<String, dynamic>> items = [
    {
      'title': '카페1',
      'categories': ['카페', '애견동반'],
      'tags': ['소형견', '중형견'],
      'images': [
        'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
      ],
      'distance': '2.5km',
    },
    {
      'title': '강아지 데려오셈',
      'categories': ['일반음식점', '애견동반'],
      'tags': ['소형견', '중형견', '대형견', '칸분리'],
      'images': [
        'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
      ],
      'distance': '4.5km',
    },
    {
      'title': '강아지 안데려옴?',
      'categories': ['일반음식점', '애견동반'],
      'tags': ['소형견', '칸분리'],
      'images': [
        'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
      ],
      'distance': '200m',
    },
  ];

  figurePosition() async {
    var position = await getPosition();
    print(position);
    return position;
  }

  @override
  void initState() {
    super.initState();
    // figurePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'HOME',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: ToggleButtons(
                renderBorder: false,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                direction: Axis.horizontal,
                onPressed: (int index) {},
                constraints: BoxConstraints(minHeight: 40.0, minWidth: 80.0),
                isSelected: _selectedFruits,
                children: fruits.map((item) {
                  return Container(
                    child: item,
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.separated(
                  padding: EdgeInsets.all(12.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ItemDetail(),
                            ),
                          );
                        },
                        child: ListItem(
                          title: items[index]['title'],
                          categories: items[index]['categories'],
                          tags: items[index]['tags'],
                          thumbnail: items[index]['images']![0],
                          distance: items[index]['distance'],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: 30.0, color: Colors.grey);
                  },
                  itemCount: items.length,
                ),
              ),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:for_noru_app/utils/get-position.dart';

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
  List<Map<String, List<String>>> items = [
    {
      'images': [
        'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
      ],
    },
    {
      'images': [
        'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
      ],
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            '반려동물 동반 가능 장소',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: ListView.separated(
            padding: EdgeInsets.all(12.0),
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {},
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(items[index].images[0]),
                  Text('좋아요 100',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('글쓴이'),
                  Text('글내용'),
                ],
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 30.0, color: Colors.grey),
            itemCount: items.length,
          ),
        ));
  }
}

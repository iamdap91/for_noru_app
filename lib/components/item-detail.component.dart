import 'package:flutter/material.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  Map<String, dynamic> item = {
    'title': '카페1',
    'categories': ['카페', '애견동반'],
    'tags': ['소형견', '중형견'],
    'images': [
      'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
    ],
    'distance': '2.5km',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          item['title'],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

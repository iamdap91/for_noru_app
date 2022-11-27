import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:for_noru_app/components/percentage-indicator.component.dart';

import 'gallery.component.dart';

const backgroundButtonColor = Color.fromRGBO(0, 0, 0, 0.6);

class ItemDetail extends StatefulWidget {
  ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  Map<String, dynamic> item = {
    'title': '애견동반 카페 - AAA',
    'description': '여기는 이런이런게 돼요. \n이건 안되구 저건 되여',
    'categories': ['카페', '애견동반'],
    'tags': ['소형견', '중형견'],
    'address': '서울특별시 김김김구 나나나동 999-123, 111호',
    'images': [
      'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
      'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg',
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(
          item['title'],
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'map'),
      //     BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'phone'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.edit_outlined), label: 'review'),
      //   ],
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: item['images'].length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Gallery(
                          images: item['images'],
                          initialPage: pageViewIndex,
                        );
                      }),
                    );
                  },
                  child: Hero(
                    tag: '$itemIndex',
                    child: Image.network(
                      item['images'][itemIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                enableInfiniteScroll: false,
                height: 400,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
              ),
              carouselController: CarouselController(),
            ),
            Divider(height: 20),
            Container(
              child: Row(
                children: [],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(children: [
                      Icon(Icons.map),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('지도'),
                      )
                    ]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundButtonColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(children: [
                      Icon(Icons.phone),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('010-4780-2291'),
                      )
                    ]),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundButtonColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: item['address']))
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('주소가 복사되었어요!'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                });
              },
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copy),
                    Text(
                      item['address'],
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
            ),
            Divider(height: 20),
            PercentageIndicator(text: '소형견 입장이 가능해요', percentage: 0.87),
            PercentageIndicator(text: '중형견 입장이 가능해요', percentage: 0.53),
            PercentageIndicator(text: '대형견 입장이 가능해요', percentage: 0.09),
            PercentageIndicator(text: '소, 중/대의 칸이 나뉘어 있어요', percentage: 0.3),
          ],
        ),
      ),
    );
  }
}

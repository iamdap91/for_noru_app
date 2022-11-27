import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'content-detail.component.dart';
import 'list-item.component.dart';

class ContentList extends StatefulWidget {
  const ContentList({Key? key}) : super(key: key);

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
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
    {
      'title': '강아지 안데려옴?',
      'categories': ['일반음식점', '애견동반'],
      'tags': ['소형견', '칸분리'],
      'images': [
        'https://ldb-phinf.pstatic.net/20210427_49/1619501570900CAtdy_JPEG/SoZtwIlyvA-zmwrVXqs6wSXK.jpeg.jpg'
      ],
      'distance': '200m',
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      items.add(items[0]);
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 200));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
          padding: EdgeInsets.all(12.0),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ContentDetail(),
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
    );
  }
}

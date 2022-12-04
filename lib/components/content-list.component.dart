import 'package:flutter/material.dart';
import 'package:for_noru_app/components/shimmers/content-list-shimmer.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../stores/list-view-store.dart';
import 'content-detail.component.dart';
import 'list-item.component.dart';

class ContentList extends StatefulWidget {
  const ContentList({Key? key}) : super(key: key);

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<ListViewStore>().searchRequest();
  }

  void _onRefresh() async {
    setState(() {
      context.read<ListViewStore>().searchRequest();
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ListViewStore>().places.length == 0) {
      return ContentListShimmer();
    }

    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: context.watch<ListViewStore>().places.length == 0
            ? Container(
                child: Center(
                  child: Text(
                    '반경 30km 안에 반려동물 동반 가능한 장소가 없어요 🥲',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.all(12.0),
                itemBuilder: (BuildContext context, int index) {
                  var places = context.watch<ListViewStore>().places;
                  if (places.length == 0 || index >= places.length) {
                    return SizedBox();
                  }
                  var placeInfo = places[index];

                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ContentDetail(placeInfo: placeInfo),
                          ),
                        );
                      },
                      child: ListItem(
                        name: placeInfo['name'],
                        categories: placeInfo['categories']?.cast<String>(),
                        tags: placeInfo['tags']?.cast<String>(),
                        images: placeInfo['images'].cast<String>(),
                        distance: placeInfo['distance'],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 30.0, color: Colors.grey);
                },
                itemCount: context.watch<ListViewStore>().places.length,
              ),
      ),
    );
  }
}

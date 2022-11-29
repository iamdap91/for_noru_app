import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../stores/list-view-store.dart';
import '../utils/get-position.dart';
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
    _makeSearchRequest();
  }

  Future<void> _makeSearchRequest() async {
    Position position = await getPosition();
    // print(position);
    context
        .read<ListViewStore>()
        .searchRequest(position.latitude, position.longitude);
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      // items.add(items[0]);
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
            var item = context.watch<ListViewStore>().listItems[index];

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
                  name: item['name'],
                  categories: item['categories']?.cast<String>(),
                  tags: item['tags']?.cast<String>(),
                  thumbnail: item['images'][0],
                  distance: item['distance'],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 30.0, color: Colors.grey);
          },
          itemCount: context.watch<ListViewStore>().listItems.length,
        ),
      ),
    );
  }
}

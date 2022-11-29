import 'package:flutter/material.dart';
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
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,
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

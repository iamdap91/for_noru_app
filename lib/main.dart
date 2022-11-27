import 'package:flutter/material.dart';
import 'package:for_noru_app/components/content-list.component.dart';
import 'package:for_noru_app/components/filter-bar.component.dart';
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
          'HOME',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          FilterBar(),
          ContentList(),
        ],
      ),
    );
  }
}

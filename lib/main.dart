import 'package:flutter/material.dart';
import 'package:for_noru_app/components/content-list.component.dart';
import 'package:for_noru_app/components/filter-bar.component.dart';
import 'package:for_noru_app/components/guide.component.dart';
import 'package:for_noru_app/utils/get-position.dart';
import 'package:shared_preferences/shared_preferences.dart';

var openTutorial = (context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Guide();
      }),
    );

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
  figureTutorial() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool? seen = storage.getBool('seenTutorial');
    print(seen);
    if (seen == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return Guide();
        }),
      );
    }
  }

  figurePosition() async {
    var position = await getPosition();
    print(position);
    return position;
  }

  @override
  void initState() {
    super.initState();
    figureTutorial();
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Guide();
                  }),
                );
              },
              icon: Icon(Icons.menu_book, color: Colors.black))
        ],
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

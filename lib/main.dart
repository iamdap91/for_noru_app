import 'package:flutter/material.dart';
import 'package:for_noru_app/components/content-list.component.dart';
import 'package:for_noru_app/components/filter-bar.component.dart';
import 'package:for_noru_app/components/guide.component.dart';
import 'package:for_noru_app/stores/list-view-store.dart';
import 'package:for_noru_app/utils/get-position.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> Function(BuildContext) openTutorial = (BuildContext context) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Guide()),
  );
};

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (c) => ListViewStore(),
      child: MaterialApp(home: NoruApp()),
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
    // storage.remove('seenTutorial');
    bool? seen = storage.getBool('seenTutorial');
    if (seen == null) {
      openTutorial(context);
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
            onPressed: () => openTutorial(context),
            icon: Icon(Icons.menu_book, color: Colors.black),
          )
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

import 'package:flutter/material.dart';
import 'package:for_noru_app/dialog.dart';
import 'package:for_noru_app/models/friend.model.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    MaterialApp(
      home: FriendApp(),
    ),
  );
}

class FriendApp extends StatefulWidget {
  const FriendApp({Key? key}) : super(key: key);

  @override
  State<FriendApp> createState() => _FriendAppState();
}

class _FriendAppState extends State<FriendApp> {
  final List<Friend> friends = [
    Friend(name: 'noru 1', like: 0),
    Friend(name: 'noru 2', like: 0),
    Friend(name: 'noru 3', like: 0),
    Friend(name: 'noru 4', like: 0),
    Friend(name: 'noru 5', like: 0),
  ];

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  addFriend(String name) {
    setState(() {
      friends.add(new Friend(name: name, like: 0));
    });
  }

  editFriend(int index, String name) {
    setState(() {
      friends[index].name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('friends'),
        actions: [
          IconButton(
            onPressed: () {
              getPermission();
            },
            icon: Icon(Icons.contacts),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(friends.length.toString()),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DialogUI(
              friends: friends,
              addFriend: addFriend,
              editFriend: editFriend,
            ),
          );
        },
      ),
      body: ListView.separated(
          itemCount: friends.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/noru.jpeg', width: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(friends[index].name),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (context) => DialogUI(
                            friends: friends,
                            addFriend: addFriend,
                            editFriend: editFriend,
                            index: index,
                          ),
                        )
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 10.0, color: Colors.blue)),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.icecream), label: 'dummy'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
      ]),
    );
  }
}

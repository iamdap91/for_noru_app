import 'package:flutter/material.dart';

import 'models/friend.model.dart';

class DialogUI extends StatelessWidget {
  DialogUI({
    Key? key,
    required List<Friend> friends,
    required this.addFriend,
    required this.editFriend,
    this.index,
  }) : super(key: key);
  final Function(String name) addFriend;
  final Function(int index, String name) editFriend;
  final int? index;
  final userInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 115,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(controller: userInput),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('cancel'),
                  ),
                  TextButton(
                      onPressed: () {
                        (index is int)
                            ? editFriend(index!, userInput.text)
                            : addFriend(userInput.text);
                        Navigator.pop(context);
                      },
                      child: Text('ok')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/get-position.dart';

List<String> fruits = ['전체', '카페', '음식점'];
final List<bool> _selectedFruits = <bool>[true, false, false];

class FilterBar extends StatefulWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
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
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: ToggleButtons(
        renderBorder: false,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        direction: Axis.horizontal,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < _selectedFruits.length; i++) {
              _selectedFruits[i] = i == index;
            }
          });
        },
        constraints: BoxConstraints(minHeight: 40.0, minWidth: 80.0),
        isSelected: _selectedFruits,
        children: fruits.map((item) {
          return Container(
            child: Text(item),
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
          );
        }).toList(),
      ),
    );
  }
}

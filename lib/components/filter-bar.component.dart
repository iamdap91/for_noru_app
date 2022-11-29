import 'package:flutter/material.dart';
import 'package:for_noru_app/stores/list-view-store.dart';
import 'package:provider/provider.dart';

List<String> categories = ['전체', '카페', '음식점'];
final List<bool> selectedCategories = <bool>[true, false, false];

class FilterBar extends StatefulWidget {
  const FilterBar({Key? key}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: ToggleButtons(
        renderBorder: false,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        direction: Axis.horizontal,
        onPressed: (int index) {
          context.read<ListViewStore>().selectCategory(index);
        },
        constraints: BoxConstraints(minHeight: 40.0, minWidth: 80.0),
        isSelected: context.watch<ListViewStore>().categorySelections,
        children: context.watch<ListViewStore>().categories.map((item) {
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

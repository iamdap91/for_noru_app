import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_noru_app/utils/get-position.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../constants/api-path.dart';

class ListViewStore extends ChangeNotifier {
  bool loading = false;
  final List<String> categories = ['카페', '음식점', '미용실'];
  final List<bool> categorySelections = [true, false, false];

  List<dynamic> places = [];

  void selectCategory(int index) {
    for (int i = 0; i < categories.length; i++) {
      categorySelections[i] = i == index;
    }
    searchRequest();
    notifyListeners();
  }

  void searchRequest() async {
    loading = true;
    places = [];
    Position position = await getPosition();
    String url = '${API_PATH}/api/search';
    String query =
        'lat=${position.latitude}&lon=${position.longitude}&category=${categories[categorySelections.indexOf(true)]}';

    Response response = await get(Uri.parse('$url?$query'));
    var result = jsonDecode(response.body);

    places = result['hits'];
    notifyListeners();
    loading = false;
  }
}

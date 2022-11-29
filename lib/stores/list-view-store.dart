import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_noru_app/utils/get-position.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class ListViewStore extends ChangeNotifier {
  final List<String> categories = ['카페', '음식점'];
  final List<bool> categorySelections = [true, false];
  int currentIndex = 0;

  List<dynamic> listItems = [];

  void selectCategory(int index) {
    for (int i = 0; i < categories.length; i++) {
      categorySelections[i] = i == index;
      if (i == index) {
        currentIndex = index;
      }
    }
    searchRequest();
    notifyListeners();
  }

  Future<void> searchRequest() async {
    Position position = await getPosition();
    String url = 'http://192.168.0.101:3333/api/search';
    String query =
        'lat=${position.latitude}&lon=${position.longitude}&category=${categories[currentIndex]}';

    Response response = await get(Uri.parse('$url?$query'));
    var result = jsonDecode(response.body);

    listItems = result['hits'];
    notifyListeners();
  }
}

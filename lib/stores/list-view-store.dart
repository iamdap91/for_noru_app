import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:for_noru_app/utils/get-position.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class ListViewStore extends ChangeNotifier {
  final List<String> categories = ['전체', '카페', '음식점'];
  final List<bool> categorySelections = [true, false, false];
  int currentIndex = 0;

  List<dynamic> listItems = [];

  void selectCategory(int index) {
    for (int i = 0; i < categories.length; i++) {
      categorySelections[i] = i == index;
    }
    notifyListeners();
  }

  Future<void> searchRequest() async {
    Position position = await getPosition();
    Response response = await get(Uri.parse(
        'http://192.168.0.101:3333/api/search?lat=${position.latitude}&lon=${position.longitude}'));
    var result = jsonDecode(response.body);

    listItems = result['hits'];
    notifyListeners();
  }
}

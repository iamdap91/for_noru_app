import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants/vote-type.dart';
import '../utils/get-device-id.dart';

class ContentStore extends ChangeNotifier {
  dynamic placeInfo = null;

  Future<void> findContent({required String id}) async {
    placeInfo = null;

    Response response = await get(
      Uri.parse('http://192.168.0.101:3333/api/search/$id'),
    );
    placeInfo = jsonDecode(response.body);
    notifyListeners();
  }

  Future<String> vote({
    required int code,
    required VOTE_TYPE voteType,
    required VOTE_CAST_TYPE castType,
  }) async {
    String? deviceId = await getDeviceId();

    if (deviceId == null) {
      return '기기 정보를 읽어올 수 없어요!';
    }

    Response response = await post(
      Uri.parse('http://192.168.0.101:3333/api/places/vote'),
      headers: {'Content-Type': ' application/json'},
      body: json.encode({
        'code': code,
        'voteType': voteType.name,
        'castType': castType.name,
        'deviceId': deviceId,
      }),
    );

    switch (response.statusCode) {
      case 201:
        return '투표에 성공했어요!';
      case 400:
        return '이미 투표하셨어요!';
      default:
        return '알 수 없는 에러가 발생하였어요!';
    }
  }
}

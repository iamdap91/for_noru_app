import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants/api-path.dart';
import '../constants/vote-type.dart';
import '../utils/get-device-id.dart';

class ContentStore extends ChangeNotifier {
  dynamic placeInfo = null;
  dynamic percentages = null;

  Future<void> findVotes({required String id}) async {
    Response response = await get(
      Uri.parse('${API_PATH}/api/votes/$id'),
    );

    percentages = jsonDecode(response.body);
    notifyListeners();
  }

  Future<void> findOne({required String id}) async {
    placeInfo = null;

    Response response = await get(
      Uri.parse('${API_PATH}/api/search/$id'),
    );
    placeInfo = jsonDecode(response.body);
    notifyListeners();
  }

  Future<String> vote({
    required String id,
    required VOTE_TYPE voteType,
    required VOTE_CAST_TYPE castType,
  }) async {
    String? deviceId = await getDeviceId();

    if (deviceId == null) {
      return '기기 정보를 읽어올 수 없어요!';
    }

    Response response = await post(
      Uri.parse('${API_PATH}/api/votes'),
      headers: {'Content-Type': ' application/json'},
      body: json.encode({
        'id': id,
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

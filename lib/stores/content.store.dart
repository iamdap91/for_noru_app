import 'package:flutter/material.dart';

import '../utils/get-device-id.dart';

class ContentStore extends ChangeNotifier {
  Future<void> vote() async {
    String? id = await getDeviceId();
    print(id);
  }
}

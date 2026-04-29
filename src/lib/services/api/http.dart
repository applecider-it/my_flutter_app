import 'dart:io';

import 'package:flutter/foundation.dart';

/// Jsonヘッダー
Map<String, String> getJsonHeaders() {
  return {'Content-Type': 'application/json'};
}

/// API用URL
String getApiUrl(uri) {
  // HOST名
  // Androidエミュレータは、localhostの場合は 10.0.2.2 を使う
  var host = kIsWeb
      ? '127.0.0.1:3000' // Webはこっちの方が安定
      : (Platform.isAndroid ? '10.0.2.2:3000' : 'localhost:3000');

  var url = 'http://' + host + uri;

  return url;
}

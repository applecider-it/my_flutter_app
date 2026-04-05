import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// 認証関連
class AuthService {
  /// セキュアストレージのインスタンス
  final storage = FlutterSecureStorage();

  /// ログインAPI送信
  Future<Map<String, dynamic>> postLogin(String email, String password) async {
    try {
      // HOST名
      // Androidエミュレータは、localhostの場合は 10.0.2.2 を使う
      var host = '10.0.2.2:3000';

      final response = await http.post(
        Uri.parse('http://' + host + '/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final decodedJson = jsonDecode(response.body);

      return {
        'json': decodedJson,
        'response': response,
      };
    } catch (e) {
      // 通信エラー発生時

      return {'e': e};
    }
  }

  /// トークン設定
  Future<void> setToken(token) async {
    await storage.write(key: "token", value: token);
  }

  /// トークンクリア
  Future<void> clearToken() async {
    await storage.delete(key: "token");
  }

  /// ログインチェック
  Future<bool> checkLogin() async {
    final token = await storage.read(key: "token");
    return token != null;
  }
}

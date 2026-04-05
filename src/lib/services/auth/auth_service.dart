import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// 認証関連のAPI通信をまとめたクラス
class AuthService {
  // セキュアストレージのインスタンス
  final storage = FlutterSecureStorage();

  // ログインAPI送信
  Future<Map<String, dynamic>> postLogin(String email, String password) async {
    try {
      final response = await http.post(
        // 接続先URL
        // Androidエミュレータの場合は 10.0.2.2 を使う
        Uri.parse('http://10.0.2.2:3000/login'),
        // ヘッダー情報
        headers: {
          // JSON形式で送ることをサーバーに伝える
          // これがないとExpress側でreq.bodyが取れない
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final decodedJson = jsonDecode(response.body);

      // 呼び出し元に返すデータ
      return {
        // サーバーから返ってきたJSONデータ
        'json': decodedJson,

        // HTTPレスポンス全体（ステータスコードなど含む）
        'response': response,
      };
    } catch (e) {
      // 通信エラー発生時

      return {'e': e};
    }
  }

  /** トークン設定 */
  Future<void> setToken(token) async {
    await storage.write(key: "token", value: token);
  }

  /** トークンクリア */
  Future<void> clearToken() async {
    await storage.delete(key: "token");
  }

  /** ログインチェック */
  Future<bool> checkLogin() async {
    final token = await storage.read(key: "token");
    return token != null;
  }
}

// JSONを扱うためのライブラリ
// → Map ⇄ JSON文字列の変換に使う
import 'dart:convert';

// HTTP通信を行うためのパッケージ
// as http とすることで http.post のように使える
import 'package:http/http.dart' as http;

// 認証関連のAPI通信をまとめたクラス
class AuthService {
  // ログイン処理
  // Future<Map<String, dynamic>> は
  // 「非同期でMapを返す」という意味
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // ==========================
      // HTTP POSTリクエスト送信
      // ==========================

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

        // リクエストボディ（送信データ）
        // DartのMapをJSON文字列に変換して送る
        body: jsonEncode({'email': email, 'password': password}),
      );

      // ==========================
      // レスポンス処理
      // ==========================

      // response.body は JSON文字列なので
      // jsonDecodeでMapに変換する
      final decodedJson = jsonDecode(response.body);

      // 呼び出し元に返すデータ
      return {
        // サーバーから返ってきたJSONデータ
        'json': decodedJson,

        // HTTPレスポンス全体（ステータスコードなど含む）
        'response': response,
      };
    } catch (e) {
      // ==========================
      // エラー処理
      // ==========================

      // 通信エラー（接続失敗など）が発生した場合
      // 例: Connection refused

      return {
        // エラー内容をそのまま返す
        'e': e,
      };
    }
  }
}

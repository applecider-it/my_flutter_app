import 'package:flutter/material.dart';
// HTTP通信とJSON操作のためのパッケージ
import 'package:http/http.dart' as http;
import 'dart:convert';

// セキュアにデータを保存するためのパッケージ
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page.dart';

import '../services/auth/auth_service.dart';

/// ===============================
/// 開発者向け画面
/// ===============================
///
/// このページは開発者向けアプリです。
/// 擬似ログイン動作確認
///
/// StatefulWidgetを使って、画面の状態を管理します。
class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

/// ===============================
/// State（画面の状態管理）
/// ===============================
class _DevelopmentPageState extends State<DevelopmentPage> {
  // 入力フォームの値を管理するコントローラー
  TextEditingController emailController = TextEditingController(
    text: "test@example.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "1234",
  );

  // セキュアストレージのインスタンス
  final storage = FlutterSecureStorage();

  final authService = AuthService();

  Future<void> login() async {
    // ==========================
    // API呼び出し
    // ==========================

    // AuthServiceのlogin関数を実行
    // → サーバーにメール・パスワードを送る
    final result = await authService.login(
      emailController.text,
      passwordController.text,
    );

    // デバッグ用（レスポンス内容確認）
    print(result);

    // ==========================
    // 通信エラーチェック
    // ==========================

    // 'e' がある場合は try-catch に入った = 通信エラー
    if (result.containsKey('e')) {
      // エラー内容取得
      var e = result['e'];

      // コンソールに表示
      print("通信エラー: $e");

      // ユーザーにエラー表示
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("通信に失敗しました")));
    } else {
      // ==========================
      // HTTPレスポンス取得
      // ==========================

      var response = result['response'];

      // ==========================
      // 成功判定（200 OK）
      // ==========================

      if (response.statusCode == 200) {
        // サーバーから返ってきたJSONをパース
        final data = jsonDecode(response.body);

        // トークン取得（ログイン成功時）
        final token = result['json']['token'];

        // ==========================
        // トークン保存
        // ==========================

        // 端末に安全に保存（ログイン状態維持）
        await storage.write(key: "token", value: token);

        // ==========================
        // 画面遷移
        // ==========================

        // ログイン画面を置き換えてホームへ移動
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        // ==========================
        // ログイン失敗
        // ==========================

        print("ログイン失敗: ${response.statusCode}");

        // ユーザーにエラー表示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("ログイン失敗")));
      }
    }
  }

  /// ===============================
  /// UI構築
  /// ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// ---------------------------
      /// AppBar（タイトルバー）
      /// ---------------------------
      appBar: AppBar(title: const Text("Development Page")),

      /// ---------------------------
      /// メインUI
      /// ---------------------------
      body: Center(
        /// ---------------------------
        /// Columnで縦に並べる
        /// ---------------------------
        child: Column(
          children: [
            // メールアドレス入力欄
            TextField(
              controller: emailController, // 入力値を取得するためのコントローラー
              decoration: InputDecoration(labelText: "Email"),
            ),

            // パスワード入力欄
            TextField(
              controller: passwordController,
              obscureText: true, // パスワードを●表示にする
              decoration: InputDecoration(labelText: "Password"),
            ),

            // ログインボタン
            ElevatedButton(
              onPressed: () async {
                // ボタン押下時にログイン処理を実行
                await login();
              },
              child: Text("ログイン"),
            ),
          ],
        ),
      ),
    );
  }
}

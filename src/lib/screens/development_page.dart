import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_page.dart';

import '../services/auth/auth_service.dart';

/// 開発者向け画面
///
/// - 擬似ログイン動作確認
///
/// StatefulWidgetを使って、画面の状態を管理します。
class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

/// State（画面の状態管理）
class _DevelopmentPageState extends State<DevelopmentPage> {
  TextEditingController emailController = TextEditingController(
    text: "test@example.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "1234",
  );

  final authService = AuthService();

  /// ログイン処理
  Future<void> login() async {
    final result = await authService.postLogin(
      emailController.text,
      passwordController.text,
    );

    print(result);

    if (result.containsKey('e')) {
      // 通信エラー発生時

      var e = result['e'];

      print("通信エラー: $e");

      // ユーザーにエラー表示
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("通信に失敗しました")));
    } else {
      // 通信エラーがない時

      var response = result['response'];

      if (response.statusCode == 200) {
        // ログイン成功時

        final data = jsonDecode(response.body);

        final token = result['json']['token'];

        await authService.setToken(token);

        // メッセージ表示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("ログインしました")));

        // ホームへ移動
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        // ログイン失敗

        print("ログイン失敗: ${response.statusCode}");

        // エラー表示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("ログイン失敗")));
      }
    }
  }

  Future<void> logout() async {
    await authService.clearToken();

    // メッセージ表示
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("ログアウトしました")));

    // ホームへ移動
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  // UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Development Page")),

      body: Center(
        // Columnで縦に並べる
        child: Column(
          children: [
            // メールアドレス入力欄
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),

            // パスワード入力欄
            TextField(
              controller: passwordController,
              obscureText: true, // パスワードを●表示にする
              decoration: InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            // ログインボタン
            ElevatedButton(
              onPressed: () async {
                await login();
              },
              child: Text("ログイン"),
            ),

            const SizedBox(height: 100), // 間隔を空ける
            // ログアウトボタン
            ElevatedButton(
              onPressed: () async {
                await logout();
              },
              child: Text("ログアウト"),
            ),
          ],
        ),
      ),
    );
  }
}

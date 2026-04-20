import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'home_page.dart';

import '../services/auth/auth_ctrl.dart';

/// 認証動作確認用画面
///
/// - 擬似ログイン動作確認
///
/// StatefulWidgetを使って、画面の状態を管理します。
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

/// State（画面の状態管理）
class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController(
    text: "test@example.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "1234",
  );

  final authCtrl = AuthCtrl();

  /// ログイン処理
  Future<void> login() async {
    final result = await authCtrl.postLogin(
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

        await authCtrl.setToken(token);

        // メッセージ表示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("ログインしました")));

        // ホームへ移動
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
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
    await authCtrl.clearToken();

    // メッセージ表示
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("ログアウトしました")));

    // ホームへ移動
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
  }

  Future<bool> checkLogin() async {
    return await authCtrl.checkLogin();
  }

  // UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Auth Page")),
      body: Center(
        child: FutureBuilder<bool>(
          future: checkLogin(),
          builder: (context, snapshot) {
            // ローディング中
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final isLoggedIn = snapshot.data!;

            if (!isLoggedIn) {
              // 未ログイン

              // Columnで縦に並べる
              return Column(
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

                  const SizedBox(height: 10), // 間隔を空ける
                  // ログインボタン
                  ElevatedButton(onPressed: login, child: Text("ログイン")),
                ],
              );
            } else {
              // ログイン済み

              // ログアウトボタン
              return ElevatedButton(onPressed: logout, child: Text("ログアウト"));
            }
          },
        ),
      ),
    );
  }
}

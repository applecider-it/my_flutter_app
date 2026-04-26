import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../../screens/home_page.dart';

import '../api/http.dart';

// 認証管理
class AuthCtrl {
  /// セキュアストレージのインスタンス
  final storage = FlutterSecureStorage();

  /// ログインAPI送信
  Future<Map<String, dynamic>> postLogin(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(getApiUrl('/login')),
        headers: getJsonHeaders(),
        body: jsonEncode({'email': email, 'password': password}),
      );

      final decodedJson = jsonDecode(response.body);

      return {'json': decodedJson, 'response': response};
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

  /// ログインチェックとページ遷移
  Future<void> checkLoginExec(context) async {
    final isLogin = await checkLogin();

    if (!isLogin) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
            (route) => false,
      );

      // メッセージ表示
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("ログインが必要です。")));
    }
  }
}

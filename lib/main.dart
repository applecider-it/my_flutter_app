import 'package:flutter/material.dart';
import 'screens/home_page.dart';

/// ===============================
/// アプリのエントリーポイント
/// ===============================
///
/// Flutterアプリは main() から実行が開始されます。
/// runApp() に渡した Widget がアプリ全体のルートになります。
void main() {
  runApp(const MyApp()); // MyApp をルートにしてアプリを起動
}

/// ===============================
/// アプリ全体の設定
/// ===============================
///
/// MyAppはアプリ全体を包む StatelessWidget
/// ここで MaterialApp を使うことで
/// ・アプリ全体のテーマ
/// ・ホーム画面
/// ・ルーティング設定
/// などを管理できます。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      /// ---------------------------
      /// Home画面（最初に表示する画面）
      /// ---------------------------
      home: HomePage(), // screens/home_page.dart のトップ画面を指定

      /// ---------------------------
      /// デバッグバナー非表示
      /// ---------------------------
      debugShowCheckedModeBanner: false,
    );
  }
}
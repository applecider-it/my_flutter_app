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
    // MaterialApp はFlutterの基本アプリ構造
    // テーマ・ルーティング・タイトルなどを管理する
    return MaterialApp(
      // アプリ全体のデザインテーマを設定
      theme: ThemeData(
        // アプリのメインカラー
        // ボタンやAppBarなどで使われる
        primaryColor: Colors.blue[400],

        // Scaffold（画面のベース）の背景色
        scaffoldBackgroundColor: Colors.grey[200],

        // AppBar（上部ナビゲーションバー）のデザイン設定
        appBarTheme: AppBarTheme(

          // AppBarの背景色
          backgroundColor: Colors.blue[400],

          // AppBarの文字色やアイコン色
          foregroundColor: Colors.white,
        ),
      ),

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
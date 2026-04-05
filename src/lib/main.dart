import 'package:flutter/material.dart';
import 'screens/home_page.dart';

/// エントリーポイント
void main() {
  runApp(const MyApp());
}

/// アプリ全体の設定
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

      /// Home画面（最初に表示する画面）
      home: HomePage(),

      /// デバッグバナー非表示
      debugShowCheckedModeBanner: false,
    );
  }
}

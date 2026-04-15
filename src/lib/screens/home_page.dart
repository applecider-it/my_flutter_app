import 'package:flutter/material.dart';
import 'todo_page.dart';
import 'counter_page.dart';
import 'development_page.dart';
import 'auth_page.dart';

/// トップ画面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),

      /// メインUI
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直方向中央揃え
          children: [
            /// Todoページへの遷移ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoPage()),
                );
              },
              child: const Text("Todoページへ"),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            /// Counterページへの遷移ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterPage()),
                );
              },
              child: const Text("Counterページへ"),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            /// 認証動作確認用画面への遷移ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              child: const Text("Authページへ"),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            /// 開発者向けページへの遷移ボタン
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DevelopmentPage()),
                );
              },
              child: const Text("Developmentページへ"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'todo_page.dart';
import 'counter_page.dart';
import 'development_page.dart';

/// ===============================
/// トップ画面（HomePage）
/// ===============================
///
/// このページはアプリの「入り口」です。
/// ・Todoページへの遷移
/// ・Counterページへの遷移
/// など、各機能へのハブ（メニュー）として機能します。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// ---------------------------
      /// AppBar（タイトルバー）
      /// ---------------------------
      appBar: AppBar(
        title: const Text("Home Page"),
      ),

      /// ---------------------------
      /// メインUI（中央にボタンを配置）
      /// ---------------------------
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直方向中央揃え
          children: [

            /// ---------------------------
            /// Todoページへの遷移ボタン
            /// ---------------------------
            ElevatedButton(
              onPressed: () {
                /// Navigator.pushで画面遷移
                /// MaterialPageRouteを使うことで新しいページを積む
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoPage(), // TodoPageを表示
                  ),
                );
              },
              child: const Text("Todoページへ"),
            ),

            /// ---------------------------
            /// ボタン間の余白
            /// ---------------------------
            const SizedBox(height: 20),

            /// ---------------------------
            /// Counterページへの遷移ボタン
            /// ---------------------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterPage(), // CounterPageを表示
                  ),
                );
              },
              child: const Text("Counterページへ"),
            ),

            /// ---------------------------
            /// ボタン間の余白
            /// ---------------------------
            const SizedBox(height: 20),

            /// ---------------------------
            /// 開発者向けページへの遷移ボタン
            /// ---------------------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DevelopmentPage(), // DevelopmentPageを表示
                  ),
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
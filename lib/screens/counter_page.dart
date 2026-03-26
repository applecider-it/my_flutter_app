import 'package:flutter/material.dart';

/// ===============================
/// カウンター画面
/// ===============================
///
/// このページはシンプルなカウンターアプリです。
/// ・＋ボタンで1増加
/// ・－ボタンで1減少
/// ・Resetボタンで0にリセット
/// を行うことができます。
///
/// StatefulWidgetを使って、画面の状態（カウント値）を管理します。
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

/// ===============================
/// State（画面の状態管理）
/// ===============================
class _CounterPageState extends State<CounterPage> {

  /// ---------------------------
  /// カウンターの値
  /// ---------------------------
  /// countは画面の状態として保持され、ボタン操作で変化します
  int count = 0;

  /// ---------------------------
  /// カウンターを1増やす
  /// ---------------------------
  /// setState()で状態を更新 → UIが再描画される
  void increment() {
    setState(() {
      count++;
    });
  }

  /// ---------------------------
  /// カウンターを1減らす
  /// ---------------------------
  void decrement() {
    setState(() {
      count--;
    });
  }

  /// ---------------------------
  /// カウンターを0にリセット
  /// ---------------------------
  void reset() {
    setState(() {
      count = 0;
    });
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
      appBar: AppBar(
        title: const Text("Counter Page"),
      ),

      /// ---------------------------
      /// メインUI
      /// ---------------------------
      body: Center(

        /// ---------------------------
        /// Columnで縦に並べる
        /// ---------------------------
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直方向中央揃え

          children: [

            /// ---------------------------
            /// カウンターの値を表示
            /// ---------------------------
            Text(
              'Count: $count', // 現在のカウントを文字列として表示
              style: const TextStyle(
                fontSize: 32, // 見やすい文字サイズ
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20), // カウンターとボタンの間隔

            /// ---------------------------
            /// ボタンエリア（横並び）
            /// ---------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 横方向中央揃え
              children: [

                /// +ボタン
                ElevatedButton(
                  onPressed: increment, // 押すと1増加
                  child: const Text("＋"),
                ),

                const SizedBox(width: 10), // ボタン間のスペース

                /// -ボタン
                ElevatedButton(
                  onPressed: decrement, // 押すと1減少
                  child: const Text("－"),
                ),

                const SizedBox(width: 10), // ボタン間のスペース

                /// Resetボタン
                ElevatedButton(
                  onPressed: reset, // 押すと0にリセット
                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

/// カウンター画面
///
/// StatefulWidgetを使って、画面の状態（カウント値）を管理します。
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

/// State（画面の状態管理）
class _CounterPageState extends State<CounterPage> {
  int count = 0;

  /// カウンターを1増やす
  void increment() {
    setState(() {
      count++;
    });
  }

  /// カウンターを1減らす
  void decrement() {
    setState(() {
      count--;
    });
  }

  /// カウンターを0にリセット
  void reset() {
    setState(() {
      count = 0;
    });
  }

  // UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter Page")),

      /// メインUI
      body: Center(
        /// Columnで縦に並べる
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直方向中央揃え

          children: [
            /// カウンターの値を表示
            Text(
              'Count: $count',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            /// ボタンエリア（横並び）
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 横方向中央揃え
              children: [
                /// +ボタン
                ElevatedButton(onPressed: increment, child: const Text("＋")),

                const SizedBox(width: 10), // 間隔を空ける
                /// -ボタン
                ElevatedButton(onPressed: decrement, child: const Text("－")),

                const SizedBox(width: 10), // 間隔を空ける
                /// Resetボタン
                ElevatedButton(onPressed: reset, child: const Text("Reset")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

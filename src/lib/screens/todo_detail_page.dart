import 'package:flutter/material.dart';

/// Todo詳細ページ
class TodoDetailPage extends StatelessWidget {
  final String todo;

  /// コンストラクタ
  ///
  /// requiredで必ずtodoを渡す
  const TodoDetailPage({super.key, required this.todo});

  /// UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo Detail")),

      /// メインUI
      body: Center(
        child: Text(
          todo,
          style: const TextStyle(
            fontSize: 24,
          ),
          textAlign: TextAlign.center, // 中央寄せ
        ),
      ),
    );
  }
}

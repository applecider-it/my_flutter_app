import 'package:flutter/material.dart';

/// ===============================
/// Todo詳細ページ
/// ===============================
///
/// このページは、トップ画面やTodo一覧画面から
/// 1つのTodoの内容を詳細表示するための画面です。
///
/// ・StatelessWidget を使う理由:
///   Todoの内容は表示のみで状態を持たないため。
class TodoDetailPage extends StatelessWidget {

  /// ---------------------------
  /// 画面に表示するTodoの内容
  /// ---------------------------
  final String todo;

  /// ---------------------------
  /// コンストラクタ
  /// requiredで必ずtodoを渡す
  /// ---------------------------
  const TodoDetailPage({super.key, required this.todo});

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
        title: const Text("Todo Detail"),
      ),

      /// ---------------------------
      /// 本文（中央にTodoを表示）
      /// ---------------------------
      body: Center(
        child: Text(
          todo, // 引数で渡されたTodoを表示
          style: const TextStyle(
            fontSize: 24, // 文字サイズ
          ),
          textAlign: TextAlign.center, // 中央寄せ
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'todo_detail_page.dart';

/// ===============================
/// Todoメイン画面
/// ===============================
///
/// このページでは
/// ・Todoの追加
/// ・Todoの削除
/// ・Todo詳細への遷移
/// を管理しています。
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

/// ===============================
/// State（画面の状態管理）
/// ===============================
class _TodoPageState extends State<TodoPage> {

  /// ---------------------------
  /// Todoリスト
  /// ---------------------------
  /// Todo文字列を保持するリスト
  final List<String> todos = [];

  /// ---------------------------
  /// テキスト入力コントローラー
  /// ---------------------------
  /// TextField の入力値を取得・操作するために使う
  final TextEditingController controller = TextEditingController();

  /// ===============================
  /// Todo追加処理
  /// ===============================
  void addTodo() {

    /// 空文字は追加しない
    if (controller.text.isEmpty) return;

    /// setStateで状態更新 → UIが再描画される
    setState(() {
      todos.add(controller.text); // リストに追加
      controller.clear();        // 入力欄をクリア
    });
  }

  /// ===============================
  /// Todo削除処理
  /// ===============================
  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index); // 指定インデックスを削除
    });
  }

  /// ===============================
  /// UI構築
  /// ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// ---------------------------
      /// アプリバー
      /// ---------------------------
      appBar: AppBar(
        title: const Text("Todo App"),
      ),

      /// ---------------------------
      /// メインUI
      /// ---------------------------
      body: Column(
        children: [

          /// -----------------------
          /// 入力エリア
          /// -----------------------
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [

                /// テキスト入力
                Expanded(
                  child: TextField(
                    controller: controller, // 入力値をコントローラーで管理
                    decoration: const InputDecoration(
                      hintText: "Enter todo", // 入力欄のヒント
                    ),
                  ),
                ),

                /// 追加ボタン
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTodo, // ボタン押下でTodo追加
                )
              ],
            ),
          ),

          /// -----------------------
          /// Todo一覧
          /// -----------------------
          Expanded(
            child: ListView.builder(
              itemCount: todos.length, // リストの件数
              itemBuilder: (context, index) {

                /// -------------------
                /// 1行のTodo表示
                /// -------------------
                return ListTile(
                  title: Text(todos[index]), // Todo文字列を表示

                  /// -------------------
                  /// タップで詳細ページへ遷移
                  /// -------------------
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoDetailPage(
                          todo: todos[index], // 詳細画面に値を渡す
                        ),
                      ),
                    );
                  },

                  /// -------------------
                  /// 削除ボタン
                  /// -------------------
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeTodo(index), // 削除処理
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
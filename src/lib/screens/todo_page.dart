import 'package:flutter/material.dart';
import 'todo_detail_page.dart';

import '../services/auth/auth_ctrl.dart';

/// Todoメイン画面
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

/// State（画面の状態管理）
class _TodoPageState extends State<TodoPage> {
  /// Todoリスト
  final List<String> todos = [];

  /// テキスト入力コントローラー
  final TextEditingController controller = TextEditingController();

  final authCtrl = AuthCtrl();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  /// ログインチェック
  Future<void> checkLogin() async {
    await authCtrl.checkLoginExec(context);
  }

  /// Todo追加処理
  void addTodo() {
    /// 空文字は追加しない
    if (controller.text.isEmpty) return;

    /// setStateで状態更新 → UIが再描画される
    setState(() {
      todos.add(controller.text); // リストに追加
      controller.clear();        // 入力欄をクリア
    });
  }

  /// Todo削除処理
  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index); // 指定インデックスを削除
    });
  }

  /// UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),

      /// メインUI
      body: Column(
        children: [
          /// 入力エリア
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [

                /// テキスト入力
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter todo", // 入力欄のヒント
                    ),
                  ),
                ),

                /// 追加ボタン
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTodo,
                )
              ],
            ),
          ),

          /// Todo一覧
          Expanded(
            child: ListView.builder(
              itemCount: todos.length, // リストの件数
              itemBuilder: (context, index) {
                /// 1行のTodo表示
                return ListTile(
                  title: Text(todos[index]), // Todo文字列を表示

                  /// タップされたとき
                  onTap: () {
                    // 詳細ページへ遷移
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoDetailPage(
                          todo: todos[index], // 詳細画面に値を渡す
                        ),
                      ),
                    );
                  },

                  /// 削除ボタン
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeTodo(index),
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
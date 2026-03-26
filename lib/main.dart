import 'package:flutter/material.dart';

/// ===============================
/// アプリのエントリーポイント
/// ===============================
void main() {
  runApp(const TodoApp());
}

/// ===============================
/// アプリ全体の設定
/// ===============================
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// ===============================
/// Todoメイン画面
/// ===============================
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

/// ===============================
/// State（画面の状態管理）
/// ===============================
class _TodoPageState extends State<TodoPage> {

  /// Todoリスト
  final List<String> todos = [];

  /// テキスト入力コントローラー
  final TextEditingController controller = TextEditingController();

  /// ===============================
  /// Todo追加処理
  /// ===============================
  void addTodo() {

    /// 空文字は追加しない
    if (controller.text.isEmpty) return;

    setState(() {
      todos.add(controller.text);
      controller.clear();
    });
  }

  /// ===============================
  /// Todo削除処理
  /// ===============================
  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
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
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter todo",
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

          /// -----------------------
          /// Todo一覧
          /// -----------------------
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {

                /// 1行のTodo
                return ListTile(
                  title: Text(todos[index]),

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
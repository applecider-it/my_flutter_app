import 'package:flutter/material.dart';

import 'home_page.dart';

/// 開発者向け画面
///
/// StatefulWidgetを使って、画面の状態を管理します。
class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

/// State（画面の状態管理）
class _DevelopmentPageState extends State<DevelopmentPage> {
  // UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Development Page")),

      body: Center(
        // Columnで縦に並べる
        child: Column(
          children: [
            const SizedBox(height: 10), // 間隔を空ける
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Block.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Navigator pop"),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text("Navigator push"),
            ),

            const SizedBox(height: 20), // 間隔を空ける
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false,
                );
              },
              child: const Text("Navigator reset"),
            ),
          ],
        ),
      ),
    );
  }
}

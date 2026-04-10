import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'home_page.dart';

import '../services/auth/auth_ctrl.dart';

/// 開発者向け画面
///
/// - 擬似ログイン動作確認
///
/// StatefulWidgetを使って、画面の状態を管理します。
class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

/// State（画面の状態管理）
class _DevelopmentPageState extends State<DevelopmentPage> {
  TextEditingController emailController = TextEditingController(
    text: "test@example.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "1234",
  );

  bool isCameraInit = false;
  late CameraController controller;
  late List<CameraDescription> cameras;
  XFile? imageFile;

  final authCtrl = AuthCtrl();

  /// ログイン処理
  Future<void> login() async {
    final result = await authCtrl.postLogin(
      emailController.text,
      passwordController.text,
    );

    print(result);

    if (result.containsKey('e')) {
      // 通信エラー発生時

      var e = result['e'];

      print("通信エラー: $e");

      // ユーザーにエラー表示
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("通信に失敗しました")));
    } else {
      // 通信エラーがない時

      var response = result['response'];

      if (response.statusCode == 200) {
        // ログイン成功時

        final data = jsonDecode(response.body);

        final token = result['json']['token'];

        await authCtrl.setToken(token);

        // メッセージ表示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("ログインしました")));

        // ホームへ移動
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        // ログイン失敗

        print("ログイン失敗: ${response.statusCode}");

        // エラー表示
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("ログイン失敗")));
      }
    }
  }

  Future<void> logout() async {
    await authCtrl.clearToken();

    // メッセージ表示
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("ログアウトしました")));

    // ホームへ移動
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Future<void> execCamera() async {
    print("execCamera");

    if (!isCameraInit) {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();

      controller = CameraController(
        cameras[0], // 背面カメラ
        ResolutionPreset.medium,
      );

      await controller.initialize();

      isCameraInit = true;
    }

    final image = await controller.takePicture();
    print("takePicture");
    print(image.path); // 保存パス

    setState(() {
      imageFile = image;
    });
  }

  // 終了処理
  @override
  void dispose() {
    if (isCameraInit) {
      controller.dispose();

      isCameraInit = false;
    }
    super.dispose();
  }

  // UI構築

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Development Page")),

      body: Center(
        // Columnで縦に並べる
        child: Column(
          children: [
            // メールアドレス入力欄
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),

            // パスワード入力欄
            TextField(
              controller: passwordController,
              obscureText: true, // パスワードを●表示にする
              decoration: InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 10), // 間隔を空ける
            // ログインボタン
            ElevatedButton(
              onPressed: () async {
                await login();
              },
              child: Text("ログイン"),
            ),

            const SizedBox(height: 10), // 間隔を空ける
            // ログアウトボタン
            ElevatedButton(
              onPressed: () async {
                await logout();
              },
              child: Text("ログアウト"),
            ),

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

            const SizedBox(height: 10), // 間隔を空ける
            // カメラボタン
            ElevatedButton(
              onPressed: () async {
                await execCamera();
              },
              child: Text("カメラ起動+撮影"),
            ),

            if (isCameraInit)
              Expanded(
                child: controller.value.isInitialized
                    ? CameraPreview(controller)
                    : Container(),
              ),

            if (imageFile != null)
              Image.file(
                File(imageFile!.path),
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}

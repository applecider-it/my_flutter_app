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
  bool isCameraInit = false;
  late CameraController controller;
  late List<CameraDescription> cameras;
  XFile? imageFile;

  final authCtrl = AuthCtrl();

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

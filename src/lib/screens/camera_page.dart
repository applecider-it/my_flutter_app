import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

/// カメラ動作確認画面
///
/// StatefulWidgetを使って、画面の状態を管理します。
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

/// State（画面の状態管理）
class _CameraPageState extends State<CameraPage> {
  bool isCameraInit = false;
  late CameraController controller;
  late List<CameraDescription> cameras;
  XFile? imageFile;

  Future<void> execInitCamera() async {
    print("execInitCamera");

    if (!isCameraInit) {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();

      controller = CameraController(
        cameras[0], // 背面カメラ
        ResolutionPreset.medium,
      );

      await controller.initialize();

      setState(() {
        isCameraInit = true;
      });

      print("カメラ初期化");
    }
  }

  Future<void> execTakeCamera() async {
    print("execTakeCamera");

    if (!isCameraInit) {
      print("カメラが初期化されていません。");
      return;
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
      appBar: AppBar(title: const Text("Camera Page")),

      body: Center(
        // Columnで縦に並べる
        child: Column(
          children: [
            // カメラボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await execInitCamera();
                  },
                  child: Text("カメラ起動"),
                ),

                SizedBox(width: 16), // ボタンの間のスペース
                ElevatedButton(
                  onPressed: () async {
                    await execTakeCamera();
                  },
                  child: Text("撮影"),
                ),
              ],
            ),

            if (isCameraInit)
              Expanded(
                child: controller.value.isInitialized
                    ? CameraPreview(controller)
                    : Container(),
              ),

            if (imageFile != null)
              Image.file(File(imageFile!.path), height: 200),
          ],
        ),
      ),
    );
  }
}

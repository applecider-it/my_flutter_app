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
      appBar: AppBar(title: const Text("Camera Page")),

      body: Center(
        // Columnで縦に並べる
        child: Column(
          children: [
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

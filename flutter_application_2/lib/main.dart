import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// 전역 변수로 카메라 목록 저장
late List<CameraDescription> cameras;

Future<void> main() async {
  // 1. 플러터 엔진 초기화 (카메라 사용 전 필수)
  WidgetsFlutterBinding.ensureInitialized();

  // 2. 기기에 있는 카메라 목록 가져오기
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CameraScreen());
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    // 화면 켜지면 바로 카메라 준비
    initializeCamera();
  }

  // 카메라 켜는 함수
  void initializeCamera() async {
    if (cameras.isEmpty) {
      print("카메라가 없습니다!");
      return;
    }

    // 0번: 후면 카메라, 1번: 전면 카메라 (맥북은 0번이 웹캠)
    controller = CameraController(
      cameras[0],
      ResolutionPreset.medium, // 화질 설정 (너무 높으면 느려짐)
      enableAudio: false, // 오디오는 끔
    );

    await controller!.initialize();

    if (!mounted) return;

    setState(() {
      isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    // 앱 꺼질 때 카메라 반납
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // 로딩 중일 때 뺑뺑이
      );
    }

    // 카메라 화면 보여주기
    return Scaffold(
      appBar: AppBar(title: const Text("Squat Counter")),
      body: Center(child: CameraPreview(controller!)),
    );
  }
}

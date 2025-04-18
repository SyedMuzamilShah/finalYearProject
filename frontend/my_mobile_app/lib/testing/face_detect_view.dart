import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceDetectView extends StatefulWidget {
  const FaceDetectView({super.key});

  @override
  State<FaceDetectView> createState() => _FaceDetectViewState();
}

class _FaceDetectViewState extends State<FaceDetectView>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    // Pause the camera when the app is in the background
    if (state == AppLifecycleState.paused) {
      _cameraController?.stopImageStream();
    }
    // Resume the camera when the app is in the foreground
    else if (state == AppLifecycleState.resumed) {
      _cameraController?.startImageStream((image) {
        // Process the camera image (e.g., for face detection)
      });
    }
  }

  // Initialize the camera
  Future<void> _initializeCamera() async {
    try {
      // Check camera permission
      final permissionStatus = await Permission.camera.request();
      if (!permissionStatus.isGranted) {
        setState(() {
          _errorMessage = 'Camera permission denied';
        });
        return;
      }

      // Get the list of available cameras
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      // Initialize the camera controller
      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
      // Start the camera image stream (optional, for real-time processing)
      await _cameraController!.startImageStream((image) async {
        for (Plane plane in image.planes) {
        print(plane.bytes);
        }
        await Future.delayed(Duration(seconds: 2));
        // Process the camera image (e.g., for face detection)
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize camera: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Detection'),
      ),
      body: Center(
        child: _errorMessage.isNotEmpty
            ? Text(_errorMessage)
            : _isCameraInitialized
                ? CameraPreview(_cameraController!)
                : const CircularProgressIndicator(),
      ),
    );
  }
}
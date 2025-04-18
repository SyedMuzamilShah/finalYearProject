import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_mobile_app/testing/face_detect_view.dart';
import 'package:permission_handler/permission_handler.dart';

// Provider to check and request camera permission
final cameraPermissionProvider = FutureProvider<PermissionStatus>((ref) async {
  final status = await Permission.camera.status;
  if (!status.isGranted) {
    print("Camera permission not granted try to granted now");
    return await Permission.camera.request();
  }
  print("the status is $status");
  return status;
});

class FaceViewTesting extends ConsumerWidget {
  const FaceViewTesting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionStatus = ref.watch(cameraPermissionProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Camera Access')),
      body: Center(
        child: permissionStatus.when(
          data: (status) {
            if (status.isGranted) {
              return ElevatedButton(
                  onPressed: () async {
                    final cameras = await availableCameras();
                    if (cameras.isNotEmpty){
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FaceDetectView()));
                    if (result){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Face Detected Successfully!'),
                      ));
                    }
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('No Camera Found!'),
                      ));
                    }
                    
                  },
                  child: Text("Face Detect View"));
            } else if (status.isDenied) {
              return ElevatedButton(
                onPressed: () => ref.refresh(cameraPermissionProvider),
                child: Text('Request Camera Permission'),
              );
            } else if (status.isPermanentlyDenied) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Camera permission permanently denied.'),
                  ElevatedButton(
                    onPressed: () => openAppSettings(),
                    child: Text('Open Settings'),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../logger/app_logger.dart';

class ImageCaptureService {
  ImageCaptureService({required ImagePicker picker, required AppLogger logger})
    : _picker = picker,
      _logger = logger;

  final ImagePicker _picker;
  final AppLogger _logger;

  Future<String?> captureAndStoreImage() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      _logger.w('Camera permission denied.');
      return null;
    }

    final captured = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (captured == null) {
      return null;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final reportsDir = Directory('${appDir.path}/job_reports');
    if (!reportsDir.existsSync()) {
      reportsDir.createSync(recursive: true);
    }

    final targetPath =
        '${reportsDir.path}/report_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final file = File(captured.path);
    final stored = await file.copy(targetPath);

    return stored.path;
  }
}

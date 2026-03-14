import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_capture_service.dart';
import 'logging_providers.dart';

final imageCaptureServiceProvider = Provider<ImageCaptureService>((ref) {
  return ImageCaptureService(
    picker: ImagePicker(),
    logger: ref.watch(appLoggerProvider),
  );
});

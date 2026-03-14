import 'package:field_service_app/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppConfig.validate enforces API_BASE_URL', () {
    if (AppConfig.apiBaseUrl.isEmpty) {
      expect(() => AppConfig.validate(), throwsA(isA<StateError>()));
      return;
    }

    expect(() => AppConfig.validate(), returnsNormally);
  });
}

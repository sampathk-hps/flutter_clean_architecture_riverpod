# App Logger

`AppLogger` is a lightweight wrapper around [`package:logger`](https://pub.dev/packages/logger) used across the app for consistent logging.

## What it provides

- `d()` for debug logs
- `i()` for info logs
- `w()` for warning logs
- `e()` for error logs
- Optional `error` and `stackTrace` parameters on every method

It uses `PrettyPrinter` with:
- `methodCount: 0`
- `errorMethodCount: 8`
- `lineLength: 120`

## Usage

`AppLogger` is exposed through Riverpod in `core/di/logging_providers.dart`:

```dart
final appLoggerProvider = Provider<AppLogger>((ref) => AppLogger());
```

In services/repositories:

```dart
_logger.i('Sync started');
_logger.w('Using cached response');
_logger.e('Sync failed', error, stackTrace);
```

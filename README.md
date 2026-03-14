# field_service_app

Flutter app for field-service job management.

## Compile-Time Environment Configuration

This project uses compile-time environment values (`dart-define`) instead of runtime `.env` files.

`API_BASE_URL` is required and validated on app startup.

### Environment files

- `config/env/dev.json`
- `config/env/staging.json`
- `config/env/prod.json`

Each file is passed with `--dart-define-from-file`.

## Run

```bash
flutter run --dart-define-from-file=config/env/dev.json
```

If you use FVM:

```bash
fvm flutter run --dart-define-from-file=config/env/dev.json
```

## Build

```bash
flutter build apk --dart-define-from-file=config/env/prod.json
```

## Test

```bash
flutter test --dart-define-from-file=config/env/dev.json
```

## Optional single-key override

You can override any key at command time:

```bash
flutter run \
  --dart-define-from-file=config/env/dev.json \
  --dart-define=API_BASE_URL=https://api-custom.example.com/v1
```

## Notes

- Do not put true secrets in `dart-define` values for mobile apps.
- Keep these values for non-secret environment configuration only.

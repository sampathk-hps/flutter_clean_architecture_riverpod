# AGENTS.md

This guide defines how AI coding agents must work in this repository.
Goal: preserve and extend the existing SOLID + clean architecture without shortcuts.

## 1) Architecture Snapshot (Current Source of Truth)

- Platform: Flutter + Dart
- State management / DI: Riverpod providers
- Networking: Dio via `lib/core/network`
- Local storage: Isar via `lib/core/database`
- App structure (feature-first):
  - `lib/app`: app bootstrap + router
  - `lib/core`: shared infrastructure
  - `lib/features/<feature>` with `data/`, `domain/`, `presentation/`, `di/`
  - `lib/shared`: shared widgets/constants/extensions

## 2) Mandatory Core Building Blocks

Agents must reuse these files instead of creating parallel systems:

- Config: `lib/core/config/app_config.dart`
- Database service: `lib/core/database/isar_service.dart`
- Logging: `lib/core/logger/app_logger.dart`
- Networking contracts/endpoints: `lib/core/network/api_endpoints.dart` and other `lib/core/network/*` utilities
- Theming/tokens/styles: all files under `lib/core/theme/*`
- Extensions: reuse/create in `lib/shared/extensions/*` when extension behavior is needed
- Shared UI: prefer `lib/shared/widgets/*` whenever a reusable widget already fits

## 3) Non-Negotiable Dependency Direction

- `presentation` may depend on `domain` abstractions and shared/core UI helpers.
- `domain` must stay framework-agnostic (no Flutter UI imports, no Dio, no Isar).
- `data` implements `domain` repositories and handles API/DB details.
- `di` wires concrete implementations; no business logic.
- `core` provides reusable infrastructure and must stay feature-agnostic.

Rule: dependencies flow inward to abstractions, never from `domain` to `data`/`presentation`.

## 4) SOLID + Code Boundaries

- Keep files focused and single-purpose.
- Avoid cross-feature imports unless through stable `domain` or `core` contracts.
- Preserve backward behavior unless a change is explicitly requested.
- `S` Single Responsibility: one reason to change per class/file.
- `O` Open/Closed: extend via new implementations, not scattered conditionals.
- `L` Liskov: implementations must honor interface contracts.
- `I` Interface Segregation: keep repository APIs focused.
- `D` Dependency Inversion: higher layers depend on abstractions, concrete wiring in `di`.

## 5) Package Management Rule

- Do not add packages automatically.
- If a new package is required, explicitly inform the user and request they add it to `pubspec.yaml`.

## 6) UI/Theming/Design Token Rules (Strict)

- Strictly follow theme guidelines in `lib/core/theme/*`; source all theme values from there.
- Always use shared widgets when possible (`lib/shared/widgets/*`).
- Never hardcode repeated design values in feature code when a token/helper exists.
- Do not introduce ad-hoc palette values in widgets unless explicitly approved for a one-off semantic case.
- If the same style intent appears in multiple places, create one semantic helper with a general name and reuse it.
- Do not add duplicate tokens with different names for the same value.

## 7) Change Workflow (Always Follow)

1. Update `domain` contracts/entities first.
2. Implement/update `data` layer (models, mappers, datasources, repository impl).
3. Register/update providers in `<feature>/di/*_providers.dart`.
4. Update `presentation` controllers/screens last.
5. Update `lib/app/router` only when navigation changes.

## 8) Required Validation Before Completion

After meaningful changes, run:

1. `dart format <changed-files>`
2. `fvm flutter analyze`
3. `fvm flutter test`

## 9) Anti-Patterns (Disallowed)

- Direct feature UI -> data repository implementation calls.
- Domain importing presentation/data layers.
- Reintroducing `textTheme...copyWith(...)` across screens when a semantic helper exists.
- Reintroducing raw spacing/radius/shadow literals where centralized tokens exist.
- Duplicating style tokens with equivalent values under new names.
- Architectural shortcuts that bypass repository + datasource flow.

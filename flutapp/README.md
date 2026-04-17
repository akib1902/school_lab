# flutapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

folder structure

lib/
│
├── main.dart
├── app.dart
│
├── core/
│   ├── theme/
│   │   ├── dark_theme.dart
│   │   ├── light_theme.dart
│   │   └── theme_provider.dart
│   │
│   ├── constants/
│   │   └── colors.dart
│   │
│   ├── storage/
│   |   └── local_storage.dart
│   │
│   └── state/
│       └── app_state.dart
│
├── features/
│   ├── onboarding/
│   │   └── department_batch_screen.dart
│   │
│   ├── home/
│   │   └── home_screen.dart
│   │
│   ├── ai/
│   │   └── ai_screen.dart
│   │
│   ├── resources/
│   │   └── resources_screen.dart
│   │
│   └── course/
│       └── course_detail_screen.dart
│
├── widgets/
│   ├── dropdown_widget.dart
│   ├── bottom_navbar.dart
│   ├── card_container.dart
│   └── app_header.dart
│
└── services/
    └── supabase_service.dart



    getAllResources(); not 
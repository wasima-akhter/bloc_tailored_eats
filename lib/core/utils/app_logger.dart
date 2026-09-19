import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️ $message');
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      debugPrint('❌ $message');
    }
  }

  static void success(String message) {
    if (kDebugMode) {
      debugPrint('✅ $message');
    }
  }
}

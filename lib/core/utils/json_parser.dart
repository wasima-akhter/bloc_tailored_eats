class JsonParser {
  JsonParser._();

  static String string(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;

    if (value is String) {
      return value;
    }

    return value.toString();
  }

  static int integer(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;

    if (value is int) return value;

    return int.tryParse(value.toString()) ?? fallback;
  }

  static double decimal(dynamic value, {double fallback = 0}) {
    if (value == null) return fallback;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? fallback;
  }

  static bool boolean(dynamic value, {bool fallback = false}) {
    if (value == null) return fallback;

    if (value is bool) return value;

    return value.toString().toLowerCase() == 'true';
  }
}

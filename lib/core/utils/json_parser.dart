import 'dart:developer' as developer;

class JsonParser {
  JsonParser._();

  static const String _tag = 'JsonParser';

  static String string(dynamic value, {String fallback = '', String? field}) {
    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value == null) {
          return fallback;
        }

        if (value is String) {
          return value;
        }

        return value.toString();
      },
    );
  }

  static int integer(dynamic value, {int fallback = 0, String? field}) {
    if (value == null) {
      return fallback;
    }

    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value is int) {
          return value;
        }

        if (value is num) {
          return value.toInt();
        }

        if (value is String) {
          return int.parse(value);
        }

        throw FormatException('Unsupported type: ${value.runtimeType}');
      },
    );
  }

  static double decimal(dynamic value, {double fallback = 0.0, String? field}) {
    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value == null) {
          return fallback;
        }

        if (value is double) {
          return value;
        }

        if (value is num) {
          return value.toDouble();
        }

        if (value is String) {
          return double.parse(value);
        }

        throw FormatException('Unsupported type: ${value.runtimeType}');
      },
    );
  }

  static bool boolean(dynamic value, {bool fallback = false, String? field}) {
    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value == null) {
          return fallback;
        }
        if (value is bool) {
          return value;
        }

        if (value is String) {
          final normalized = value.toLowerCase().trim();

          if (normalized == 'true') return true;
          if (normalized == 'false') return false;
        }

        if (value is num) {
          if (value == 1) return true;
          if (value == 0) return false;
        }

        throw FormatException(
          'Unsupported value: $value (${value.runtimeType})',
        );
      },
    );
  }

  static DateTime? dateTime(
    dynamic value, {
    DateTime? fallback,
    String? field,
  }) {
    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value == null) {
          return fallback;
        }

        if (value is DateTime) {
          return value;
        }

        if (value is String) {
          return DateTime.parse(value);
        }

        throw FormatException('Unsupported type: ${value.runtimeType}');
      },
    );
  }

  static List<T> list<T>(
    dynamic value, {
    List<T> fallback = const [],
    String? field,
    T Function(dynamic item)? itemParser,
  }) {
    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value == null) {
          return fallback;
        }

        if (value is! List) {
          throw FormatException('Expected List but got ${value.runtimeType}');
        }

        if (itemParser == null) {
          return List<T>.from(value);
        }

        return value.map(itemParser).toList();
      },
    );
  }

  static Map<String, dynamic> map(
    dynamic value, {
    Map<String, dynamic> fallback = const {},
    String? field,
  }) {
    return _parse(
      value: value,
      field: field,
      fallback: fallback,
      parser: () {
        if (value == null) {
          return fallback;
        }

        if (value is Map<String, dynamic>) {
          return value;
        }

        if (value is Map) {
          return Map<String, dynamic>.from(value);
        }

        throw FormatException('Expected Map but got ${value.runtimeType}');
      },
    );
  }

  static T _parse<T>({
    required dynamic value,
    required String? field,
    required T fallback,
    required T Function() parser,
  }) {
    try {
      return parser();
    } catch (error, stackTrace) {
      developer.log(
        'Failed to parse field'
        '${field != null ? ' "$field"' : ''}\n'
        'Value: $value\n'
        'Type: ${value.runtimeType}\n'
        'Error: $error',
        name: _tag,
        error: error,
        stackTrace: stackTrace,
      );

      return fallback;
    }
  }
}

/*
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
*/

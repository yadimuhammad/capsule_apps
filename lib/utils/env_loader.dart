import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Custom environment variable loader that handles double quotes properly
class EnvLoader {
  static final Map<String, String> _customEnv = {};
  static bool _isLoaded = false;

  /// Load environment variables with custom double quote handling
  static Future<void> load({String fileName = '.dev.env'}) async {
    if (_isLoaded) return;

    try {
      // First, try to load the file content
      String content;
      try {
        // Try to load from assets (for Flutter apps)
        content = await rootBundle.loadString(fileName);
      } catch (e) {
        // Fallback to file system (for tests or other scenarios)
        final file = File(fileName);
        if (await file.exists()) {
          content = await file.readAsString();
        } else {
          throw Exception('Environment file $fileName not found');
        }
      }

      // Parse the content with custom double quote handling
      _parseEnvContent(content);

      // Also load with flutter_dotenv for compatibility
      await dotenv.load(fileName: fileName);

      _isLoaded = true;
    } catch (e) {
      throw Exception('Failed to load environment file: $e');
    }
  }

  /// Parse environment file content with proper double quote handling
  static void _parseEnvContent(String content) {
    final lines = content.split('\n');

    for (String line in lines) {
      line = line.trim();

      // Skip empty lines and comments
      if (line.isEmpty || line.startsWith('#')) continue;

      // Find the first = sign
      final equalIndex = line.indexOf('=');
      if (equalIndex == -1) continue;

      final key = line.substring(0, equalIndex).trim();
      String value = line.substring(equalIndex + 1).trim();

      // Handle double quotes
      if (value.startsWith('"') && value.endsWith('"') && value.length >= 2) {
        // Remove surrounding double quotes
        value = value.substring(1, value.length - 1);

        // Handle escaped characters within double quotes
        value = value
            .replaceAll('\\"', '"') // Escaped double quote
            .replaceAll('\\n', '\n') // Escaped newline
            .replaceAll('\\t', '\t') // Escaped tab
            .replaceAll('\\\\', '\\'); // Escaped backslash
      }
      // Handle single quotes (keep as is, remove quotes)
      else if (value.startsWith("'") &&
          value.endsWith("'") &&
          value.length >= 2) {
        value = value.substring(1, value.length - 1);
      }

      _customEnv[key] = value;
    }
  }

  /// Get environment variable with fallback
  static String get(String key, {String? fallback}) {
    // First check our custom parsed environment
    if (_customEnv.containsKey(key)) {
      return _customEnv[key]!;
    }

    // Fallback to flutter_dotenv
    final dotenvValue = dotenv.maybeGet(key);
    if (dotenvValue != null) {
      return dotenvValue;
    }

    // Return fallback or throw exception
    if (fallback != null) {
      return fallback;
    }

    throw Exception('Environment variable $key not found');
  }

  /// Get environment variable that might be null
  static String? maybeGet(String key, {String? fallback}) {
    try {
      return get(key, fallback: fallback);
    } catch (e) {
      return fallback;
    }
  }

  /// Check if environment variable exists
  static bool has(String key) {
    return _customEnv.containsKey(key) || dotenv.env.containsKey(key);
  }

  /// Get all environment variables
  static Map<String, String> get env => {...dotenv.env, ..._customEnv};

  /// Clear loaded environment (useful for testing)
  static void clear() {
    _customEnv.clear();
    _isLoaded = false;
  }

  /// Load environment variables for testing
  static void testLoad({required String fileInput}) {
    clear();
    _parseEnvContent(fileInput);
    _isLoaded = true;
  }
}

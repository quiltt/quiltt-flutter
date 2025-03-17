import 'package:flutter/foundation.dart';

/// Utility functions for handling URL encoding/decoding
class URLUtils {
  /// Checks if a string appears to be already URL encoded
  static bool isEncoded(String string) {
    if (string.isEmpty) return false;

    // Check for typical URL encoding patterns like %20, %3A, etc.
    final hasEncodedChars =
        RegExp(r'%[0-9A-F]{2}', caseSensitive: false).hasMatch(string);

    // Check if double encoding has occurred (e.g., %253A instead of %3A)
    final hasDoubleEncoding =
        RegExp(r'%25[0-9A-F]{2}', caseSensitive: false).hasMatch(string);

    // If we have encoded chars but no double encoding, it's likely properly encoded
    return hasEncodedChars && !hasDoubleEncoding;
  }

  /// Smart URL encoder that ensures a string is encoded exactly once
  static String smartEncodeURIComponent(String string) {
    if (string.isEmpty) return string;

    // If it's already encoded, return as is
    if (isEncoded(string)) {
      debugPrint('URL already encoded, skipping encoding: $string');
      return string;
    }

    // Otherwise, encode it
    final encoded = Uri.encodeComponent(string);
    debugPrint('URL encoded from: $string to: $encoded');
    return encoded;
  }

  /// Checks if a string appears to be double-encoded
  static bool isDoubleEncoded(String string) {
    if (string.isEmpty) return false;
    return RegExp(r'%25[0-9A-F]{2}', caseSensitive: false).hasMatch(string);
  }

  /// Normalizes a URL string by decoding it once if it appears to be double-encoded
  static String normalizeUrlEncoding(String urlString) {
    if (isDoubleEncoded(urlString)) {
      debugPrint('Detected double-encoded URL: $urlString');
      final normalized = Uri.decodeComponent(urlString);
      debugPrint('Normalized to: $normalized');
      return normalized;
    }
    return urlString;
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

/// Web-safe photo refs stored in Hive as `b64:<base64>` strings.
abstract class PhotoStorage {
  PhotoStorage._();

  static const String prefix = 'b64:';
  static const _uuid = Uuid();

  /// Reads [XFile] bytes and returns a Hive-safe photo reference.
  static Future<String> saveFromXFile(XFile image) async {
    final bytes = await image.readAsBytes();
    return encodeBytes(bytes);
  }

  static String encodeBytes(Uint8List bytes) =>
      '$prefix${base64Encode(bytes)}';

  /// Decodes a photo ref into bytes, or null if unsupported/legacy file path.
  static Uint8List? decode(String? ref) {
    if (ref == null || ref.isEmpty) return null;
    if (!ref.startsWith(prefix)) return null;
    try {
      return base64Decode(ref.substring(prefix.length));
    } catch (_) {
      return null;
    }
  }

  static bool isStoredRef(String? ref) =>
      ref != null && ref.startsWith(prefix);

  /// Optional unique id if callers need a filename-like token.
  static String newId() => _uuid.v4();
}

/// Displays a locally stored photo ref (base64) or a placeholder.
class PhotoImage extends StatelessWidget {
  const PhotoImage({
    super.key,
    required this.photoRef,
    this.fit = BoxFit.cover,
    this.placeholder,
  });

  final String? photoRef;
  final BoxFit fit;
  final Widget? placeholder;

  @override
  Widget build(BuildContext context) {
    final bytes = PhotoStorage.decode(photoRef);
    if (bytes == null) {
      return placeholder ??
          const Icon(Icons.person, color: Colors.white70, size: 40);
    }
    return Image.memory(bytes, fit: fit, gaplessPlayback: true);
  }
}

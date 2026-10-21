import 'package:flutter/services.dart';

enum ContactResult { prepared, linkUnavailable, failed }

class ContactDraft {
  const ContactDraft({
    required this.name,
    required this.email,
    required this.message,
  });
  final String name, email, message;
  String get text => 'Hello Abdelrahman,\n\n$message\n\n$name\n$email';
}

abstract final class ContactService {
  static Future<ContactResult> prepare(
    ContactDraft draft, {
    required Uri destination,
    required Future<bool> Function(Uri) openLink,
    Future<void> Function(String)? copy,
  }) async {
    try {
      await (copy ?? (text) => Clipboard.setData(ClipboardData(text: text)))(
        draft.text,
      );
    } catch (_) {
      return ContactResult.failed;
    }
    try {
      return await openLink(destination)
          ? ContactResult.prepared
          : ContactResult.linkUnavailable;
    } catch (_) {
      return ContactResult.linkUnavailable;
    }
  }
}

import 'package:flutter/material.dart';

import '../content/studio_content.dart';
import '../content/portfolio_content.dart';
import '../services/contact_service.dart';
import '../design/theme.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key, required this.arabic, required this.onPrepare});
  final bool arabic;
  final Future<ContactResult> Function(ContactDraft) onPrepare;
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController(),
      email = TextEditingController(),
      message = TextEditingController();
  bool busy = false;
  ContactResult? result;
  String t(Bilingual copy) => copy.inLanguage(widget.arabic);
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    message.dispose();
    super.dispose();
  }

  Future<void> prepare() async {
    if (busy || !form.currentState!.validate()) return;
    setState(() {
      busy = true;
      result = null;
    });
    ContactResult outcome;
    try {
      outcome = await widget.onPrepare(
        ContactDraft(
          name: name.text.trim(),
          email: email.text.trim(),
          message: message.text.trim(),
        ),
      );
    } catch (_) {
      outcome = ContactResult.failed;
    }
    if (mounted) {
      setState(() {
        busy = false;
        result = outcome;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: form,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: name,
          enabled: !busy,
          maxLength: 100,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          decoration: InputDecoration(
            labelText: t(StudioCopy.nameLabel),
            counterText: '',
          ),
          validator: (v) =>
              v == null || v.trim().isEmpty ? t(StudioCopy.requiredName) : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: email,
          enabled: !busy,
          maxLength: 254,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            labelText: t(StudioCopy.email),
            counterText: '',
          ),
          validator: (v) =>
              !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v?.trim() ?? '')
              ? t(StudioCopy.invalidEmail)
              : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: message,
          enabled: !busy,
          maxLength: 3000,
          minLines: 4,
          maxLines: 7,
          decoration: InputDecoration(
            labelText: t(StudioCopy.message),
            alignLabelWithHint: true,
          ),
          validator: (v) =>
              (v?.trim().length ?? 0) < 20 ? t(StudioCopy.shortMessage) : null,
        ),
        const SizedBox(height: 8),
        Text(
          t(StudioCopy.formNote),
          style: Theme.of(context).textTheme.bodySmall!
              .copyWith(color: Palette.of(context).muted),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: busy ? null : prepare,
          icon: busy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.arrow_outward, size: 19),
          label: Text(
            t(busy ? StudioCopy.preparing : StudioCopy.compose),
            textAlign: TextAlign.center,
          ),
        ),
        if (result != null) ...[
          const SizedBox(height: 16),
          Semantics(
            liveRegion: true,
            child: Text(
              t(switch (result!) {
                ContactResult.prepared => StudioCopy.prepared,
                ContactResult.linkUnavailable => StudioCopy.linkUnavailable,
                ContactResult.failed => StudioCopy.copyFailed,
              }),
              style: TextStyle(color: Palette.of(context).text),
            ),
          ),
        ],
      ],
    ),
  );
}

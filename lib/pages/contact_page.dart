import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/social.dart';
import 'package:portfolio/services/portfolio_service.dart';
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/widgets/animated_reveal.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _service = PortfolioService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  List<Social> _socials = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final socials = await _service.getSocials();
      setState(() {
        _socials = socials;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load data: $e');
      setState(() => _isLoading = false);
    }
  }

  void _sendMessage() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Message sent successfully!')));

    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final hint = isDark ? AppColors.darkHint : AppColors.lightHint;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
    final error = isDark ? AppColors.darkError : AppColors.lightError;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: error,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: success,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'CONNECT_WITH_ME',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: primaryText,
                    ),
              ),
              Row(
                children: [
                  Text(
                    'Status:',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: secondaryText),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Available for projects',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: success,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '// SOCIAL_CHANNELS',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '04_ITEMS',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: hint),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ..._socials.asMap().entries.map(
                    (e) => Reveal.staggered(
                      index: e.key,
                      child: _SocialCard(
                        social: e.value,
                        onTap: () => _launchUrl(e.value.url),
                      ),
                    ),
                  ),
              const SizedBox(height: AppSpacing.md),
              Reveal(
                delay: const Duration(milliseconds: 80),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'SEND_MESSAGE.exe',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Fill out the fields below to initiate contact.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: secondaryText),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      _InputField(
                        label: 'SENDER_NAME',
                        hint: 'Enter your name...',
                        controller: _nameController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _InputField(
                        label: 'EMAIL_ADDRESS',
                        hint: 'your@email.com',
                        controller: _emailController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _InputField(
                        label: 'MESSAGE_BODY',
                        hint: 'Type your message here...',
                        controller: _messageController,
                        maxLines: 4,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _sendMessage,
                          icon: const Icon(Icons.send_rounded),
                          label: const Text('EXECUTE_SEND'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Reveal(
                delay: const Duration(milliseconds: 120),
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: accent),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.description_rounded,
                          color: primaryText,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CURRICULUM_VITAE',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: primaryText,
                                  ),
                            ),
                            Text(
                              'Download latest PDF (2.4MB)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: secondaryText),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: accent),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.download_rounded,
                              color: accent,
                              size: 16,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              'GET_FILE',
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Column(
                children: [
                  Text(
                    'v1.0.4-stable',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: hint),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '© 2024 PROTO_FOLIO. ALL RIGHTS RESERVED.',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: hint),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialCard extends StatelessWidget {
  final Social social;
  final VoidCallback onTap;

  const _SocialCard({required this.social, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final background =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: divider),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: divider),
              ),
              alignment: Alignment.center,
              child: Icon(social.icon, color: social.color, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    social.platform,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: secondaryText),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    social.handle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.north_east_rounded, color: secondaryText, size: 16),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final hint = isDark ? AppColors.darkHint : AppColors.lightHint;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '>',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: secondaryText),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: this.hint,
            hintStyle: TextStyle(color: hint),
            filled: true,
            fillColor: surface,
            contentPadding: const EdgeInsets.all(AppSpacing.md),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(color: accent),
            ),
          ),
        ),
      ],
    );
  }
}

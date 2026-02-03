import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTreeVisual extends StatelessWidget {
  const WidgetTreeVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TreeNode(label: 'MaterialApp', color: primaryColor),
            _TreeConnector(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _TreeConnector(height: 30, angle: -0.5),
                        const SizedBox(width: 40),
                        _TreeConnector(height: 30, angle: 0.5),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _TreeNode(label: 'ThemeProvider', isSecondary: true),
                        const SizedBox(width: 40),
                        _TreeNode(label: 'LocaleProvider', isSecondary: true),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            _TreeConnector(height: 30),
            _TreeNode(label: 'Router (GoRouter)', color: Colors.blueAccent),
            _TreeConnector(height: 30),
            _TreeNode(label: 'AppShell', color: Colors.teal),
          ],
        ),
      ),
    );
  }
}

class _TreeNode extends StatelessWidget {
  final String label;
  final Color? color;
  final bool isSecondary;

  const _TreeNode({required this.label, this.color, this.isSecondary = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isSecondary
        ? (isDark ? Colors.grey[900] : Colors.grey[100])
        : (color ?? Theme.of(context).colorScheme.surface);
    final textColor = isSecondary
        ? (isDark ? Colors.white70 : Colors.black87)
        : (color != null
              ? (!isDark ? Colors.white : Colors.black)
              : Theme.of(context).colorScheme.onSurface);

    return _PulseAnimation(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                color?.withValues(alpha: 0.5) ??
                Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (color ?? Colors.black).withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _PulseAnimation extends StatefulWidget {
  final Widget child;
  const _PulseAnimation({required this.child});

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.child);
  }
}

class _TreeConnector extends StatelessWidget {
  final double height;
  final double angle; // in radians

  const _TreeConnector({this.height = 20, this.angle = 0});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline.withValues(alpha: 0.3);

    return Transform.rotate(
      angle: angle,
      child: Container(width: 2, height: height, color: color),
    );
  }
}

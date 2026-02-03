import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final bool showRimLight;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 12,
    this.opacity = 0.1,
    this.borderRadius = 16,
    this.color,
    this.padding,
    this.border,
    this.showRimLight = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = color ?? (isDark ? Colors.white : Colors.black);
    final primary = Theme.of(context).colorScheme.primary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: baseColor.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border:
                border ??
                Border.all(
                  color: baseColor.withValues(alpha: isDark ? 0.08 : 0.05),
                  width: 1.5,
                ),
          ),
          child: Stack(
            children: [
              if (showRimLight)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _RimLightPainter(
                      color: isDark
                          ? primary.withValues(alpha: 0.15)
                          : Colors.white.withValues(alpha: 0.4),
                      radius: borderRadius,
                    ),
                  ),
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _RimLightPainter extends CustomPainter {
  final Color color;
  final double radius;

  _RimLightPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color,
          Colors.transparent,
          Colors.transparent,
          color.withValues(alpha: 0.1),
        ],
        stops: const [0.0, 0.4, 0.6, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RimLightPainter oldDelegate) => false;
}

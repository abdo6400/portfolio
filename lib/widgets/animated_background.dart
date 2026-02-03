import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = Offset(
            (event.localPosition.dx / MediaQuery.of(context).size.width) * 2 -
                1,
            (event.localPosition.dy / MediaQuery.of(context).size.height) * 2 -
                1,
          );
        });
      },
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(_controller.value * 2 - 1, -1),
                    end: Alignment(-(_controller.value * 2 - 1), 1),
                    colors: isDark
                        ? [
                            const Color(0xFF0F0F0F),
                            const Color(0xFF1A1A1A),
                            const Color(0xFF0F0F1A),
                          ]
                        : [
                            const Color(0xFFF5F5F7),
                            const Color(0xFFE8E8ED),
                            const Color(0xFFF0F0F5),
                          ],
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _BlobPainter(
                    progress: _controller.value,
                    mousePos: _mousePos,
                    isDark: isDark,
                    primaryColor: Theme.of(context).colorScheme.primary,
                    accentColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  final double progress;
  final Offset mousePos;
  final bool isDark;
  final Color primaryColor;
  final Color accentColor;

  _BlobPainter({
    required this.progress,
    required this.mousePos,
    required this.isDark,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    final t1 = progress * 2 * math.pi;
    final t2 = (progress + 0.5) * 2 * math.pi;

    // Blob 1 (Primary Depth)
    final x1 = size.width * (0.5 + 0.3 * math.cos(t1)) + (mousePos.dx * 30);
    final y1 = size.height * (0.3 + 0.2 * math.sin(t1)) + (mousePos.dy * 30);
    paint.color = primaryColor.withOpacity(isDark ? 0.05 : 0.08);
    canvas.drawCircle(Offset(x1, y1), size.width * 0.4, paint);

    // Blob 2 (Secondary Depth)
    final x2 = size.width * (0.4 + 0.2 * math.cos(t2)) + (mousePos.dx * -50);
    final y2 = size.height * (0.7 + 0.3 * math.sin(t2)) + (mousePos.dy * -50);
    paint.color = accentColor.withOpacity(isDark ? 0.03 : 0.05);
    canvas.drawCircle(Offset(x2, y2), size.width * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) => true;
}

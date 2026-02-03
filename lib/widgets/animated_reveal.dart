import 'package:flutter/material.dart';

/// Direction the widget will slide in from.
enum RevealDirection { up, down, left, right }

/// A lightweight fade + slide-in animation that plays on first build.
///
/// Ideal for simple list or section reveals without external packages.
class Reveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offset;
  final Curve curve;
  final RevealDirection direction;

  const Reveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 420),
    this.delay = Duration.zero,
    this.offset = 16,
    this.curve = Curves.easeOutCubic,
    this.direction = RevealDirection.up,
  });

  /// Convenience factory for staggered lists.
  factory Reveal.staggered({
    Key? key,
    required int index,
    required Widget child,
    Duration baseDelay = const Duration(milliseconds: 40),
    Duration step = const Duration(milliseconds: 60),
    RevealDirection direction = RevealDirection.up,
  }) {
    return Reveal(
      key: key,
      child: child,
      delay: baseDelay + step * index,
      direction: direction,
    );
  }

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);

    Offset begin;
    switch (widget.direction) {
      case RevealDirection.up:
        begin = Offset(0, widget.offset / 100); // subtle move from bottom
        break;
      case RevealDirection.down:
        begin = Offset(0, -widget.offset / 100);
        break;
      case RevealDirection.left:
        begin = Offset(widget.offset / 100, 0);
        break;
      case RevealDirection.right:
        begin = Offset(-widget.offset / 100, 0);
        break;
    }
    _slide = Tween<Offset>(begin: begin, end: Offset.zero).animate(curved);

    // Start after optional delay
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

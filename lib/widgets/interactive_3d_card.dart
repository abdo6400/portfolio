import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class Interactive3DCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final double scale;

  const Interactive3DCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 0.1,
    this.scale = 1.02,
  });

  @override
  State<Interactive3DCard> createState() => _Interactive3DCardState();
}

class _Interactive3DCardState extends State<Interactive3DCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _tilt = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerMove(PointerEvent event, BoxConstraints constraints) {
    setState(() {
      final x = (event.localPosition.dx / constraints.maxWidth) * 2 - 1;
      final y = (event.localPosition.dy / constraints.maxHeight) * 2 - 1;
      _tilt = Offset(y, -x);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onEnter: (_) => _controller.forward(),
          onExit: (_) {
            setState(() => _tilt = Offset.zero);
            _controller.reverse();
          },
          onHover: (event) => _onPointerMove(event, constraints),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final scale = lerpDouble(1.0, widget.scale, _controller.value)!;
              final tiltX = _tilt.dx * widget.maxTiltAngle * _controller.value;
              final tiltY = _tilt.dy * widget.maxTiltAngle * _controller.value;

              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..rotateX(tiltX)
                  ..rotateY(tiltY)
                  ..scale(scale),
                alignment: FractionalOffset.center,
                child: child,
              );
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}

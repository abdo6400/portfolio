import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A native vertical sliver that scrolls tall content first, then pins its last
/// viewport while the next opaque sliver covers it. Later slivers must paint on
/// top (SliverPaintOrder.lastIsTop). It owns no ticker or scroll controller.
class StackedSectionSliver extends SingleChildRenderObjectWidget {
  const StackedSectionSliver({
    super.key,
    required super.child,
    required this.enabled,
    this.pin = true,
  });
  final bool enabled;
  final bool pin;

  @override
  RenderStackedSection createRenderObject(BuildContext context) =>
      RenderStackedSection(enabled, pin);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderStackedSection renderObject,
  ) {
    renderObject
      ..enabled = enabled
      ..pin = pin;
  }
}

class RenderStackedSection extends RenderSliverSingleBoxAdapter {
  RenderStackedSection(this._enabled, this._pin);

  bool _enabled, _pin;
  double _position = 0, _extent = 0, _cover = 0;
  Matrix4 _transform = Matrix4.identity();
  final LayerHandle<TransformLayer> _layer = LayerHandle<TransformLayer>();

  bool get enabled => _enabled;
  set enabled(bool value) {
    if (_enabled == value) return;
    _enabled = value;
    markNeedsLayout();
  }

  bool get pin => _pin;
  set pin(bool value) {
    if (_pin == value) return;
    _pin = value;
    markNeedsLayout();
  }

  double get scrollStart => constraints.precedingScrollExtent;
  double get panelExtent => _extent;
  double get coverProgress => _cover;
  double get paintScale => 1 - .022 * _cover;

  @override
  void performLayout() {
    assert(constraints.axisDirection == AxisDirection.down);
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final viewport = constraints.viewportMainAxisExtent;
    child!.layout(
      constraints.asBoxConstraints(minExtent: enabled ? viewport : 0),
      parentUsesSize: true,
    );
    _extent = child!.size.height;
    final offset = constraints.scrollOffset;
    final pinStart = math.max(0.0, _extent - viewport);
    final pinned = enabled && pin;
    _position = -(pinned ? math.min(offset, pinStart) : offset);
    _cover = pinned ? ((offset - pinStart) / viewport).clamp(0.0, 1.0) : 0;
    final covered = pinned && offset >= _extent;
    final paintExtent = covered
        ? 0.0
        : math.min(
            math.max(0.0, _extent + _position),
            constraints.remainingPaintExtent,
          );
    geometry = SliverGeometry(
      scrollExtent: _extent,
      paintExtent: paintExtent,
      layoutExtent: math.min(math.max(0.0, _extent - offset), paintExtent),
      maxPaintExtent: _extent,
      hitTestExtent: paintExtent,
      cacheExtent: covered
          ? 0
          : calculateCacheOffset(constraints, from: 0, to: _extent),
      // Deliberately no obstruction/overlap: the next panel occupies the same
      // viewport rather than stacking underneath a conventional pinned header.
      maxScrollObstructionExtent: 0,
      hasVisualOverflow: true,
    );
    final width = constraints.crossAxisExtent;
    final scale = paintScale;
    _transform = Matrix4.identity()
      ..translateByDouble(width / 2, viewport / 2, 0, 1)
      ..scaleByDouble(scale, scale, 1, 1)
      ..translateByDouble(-width / 2, -viewport / 2 + _position, 0, 1);
    (child!.parentData! as SliverPhysicalParentData).paintOffset = Offset(
      0,
      _position,
    );
  }

  @override
  double childMainAxisPosition(RenderBox child) => _position;

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {
    transform.multiply(_transform);
  }

  @override
  bool hitTestChildren(
    SliverHitTestResult result, {
    required double mainAxisPosition,
    required double crossAxisPosition,
  }) =>
      child != null &&
      BoxHitTestResult.wrap(result).addWithPaintTransform(
        transform: _transform,
        position: Offset(crossAxisPosition, mainAxisPosition),
        hitTest: (result, position) =>
            child!.hitTest(result, position: position),
      );

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null || !geometry!.visible) {
      _layer.layer = null;
      return;
    }
    _layer.layer = context.pushTransform(
      needsCompositing,
      offset,
      _transform,
      (context, offset) => context.paintChild(child!, offset),
      oldLayer: _layer.layer,
    );
    if (_cover > 0) {
      context.canvas.drawRect(
        offset & Size(constraints.crossAxisExtent, geometry!.paintExtent),
        Paint()..color = Color.fromRGBO(0, 0, 0, .08 * _cover),
      );
    }
  }

  @override
  void dispose() {
    _layer.layer = null;
    super.dispose();
  }
}

/// Keeps keyboard/focus reveals within the readable range of a pinned panel.
/// Ordinary scrolling and non-pinned sections use Flutter's standard behavior.
class StackedScrollController extends ScrollController {
  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) => _StackedScrollPosition(
    physics: physics,
    context: context,
    oldPosition: oldPosition,
    initialPixels: initialScrollOffset,
    keepScrollOffset: keepScrollOffset,
  );
}

class _StackedScrollPosition extends ScrollPositionWithSingleContext {
  _StackedScrollPosition({
    required super.physics,
    required super.context,
    super.oldPosition,
    super.initialPixels,
    super.keepScrollOffset,
  });

  @override
  Future<void> ensureVisible(
    RenderObject object, {
    double alignment = 0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
    RenderObject? targetRenderObject,
  }) {
    RenderObject? ancestor = object;
    while (ancestor != null && ancestor is! RenderStackedSection) {
      ancestor = ancestor.parent;
    }
    if (ancestor is! RenderStackedSection ||
        !ancestor.enabled ||
        !ancestor.pin) {
      return super.ensureVisible(
        object,
        alignment: alignment,
        duration: duration,
        curve: curve,
        alignmentPolicy: alignmentPolicy,
        targetRenderObject: targetRenderObject,
      );
    }
    final viewport = RenderAbstractViewport.maybeOf(object);
    if (viewport == null) return Future<void>.value();
    final effectiveAlignment = switch (alignmentPolicy) {
      ScrollPositionAlignmentPolicy.explicit => alignment,
      ScrollPositionAlignmentPolicy.keepVisibleAtStart => 0.0,
      ScrollPositionAlignmentPolicy.keepVisibleAtEnd => 1.0,
    };
    final rect = targetRenderObject == null || targetRenderObject == object
        ? null
        : MatrixUtils.transformRect(
            targetRenderObject.getTransformTo(object),
            targetRenderObject.paintBounds,
          );
    final start = ancestor.scrollStart;
    final end = start + math.max(0.0, ancestor.panelExtent - viewportDimension);
    var target = viewport
        .getOffsetToReveal(object, effectiveAlignment, rect: rect)
        .offset
        .clamp(start, end);
    if (pixels >= start && pixels <= end) {
      if (alignmentPolicy == ScrollPositionAlignmentPolicy.keepVisibleAtStart) {
        target = math.min(target, pixels);
      }
      if (alignmentPolicy == ScrollPositionAlignmentPolicy.keepVisibleAtEnd) {
        target = math.max(target, pixels);
      }
    }
    target = target.clamp(minScrollExtent, maxScrollExtent);
    if (target == pixels) return Future<void>.value();
    if (duration == Duration.zero) {
      jumpTo(target);
      return Future<void>.value();
    }
    return animateTo(target, duration: duration, curve: curve);
  }
}

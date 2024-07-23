import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key,
      required this.desktop,
      required this.largeMobile,
      required this.mobile,
      required this.tablet,
      this.extraLargeScreen});
  final Widget desktop;
  final Widget? largeMobile;
  final Widget mobile;
  final Widget? tablet;
  final Widget? extraLargeScreen;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width <= 500;
  }

  static bool isLargeMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width <= 700;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 1080;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 1024;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 1400;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 1400 && extraLargeScreen != null) {
      return extraLargeScreen!;
    } else if (size.width >= 1080) {
      return desktop;
    } else if (size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (size.width >= 500 && largeMobile != null) {
      return largeMobile!;
    } else {
      return mobile;
    }
  }
}

extension WidgetExt on Widget {
  ///  extension method to increase size of widget when hovered
  ///
  ///  [scaleFactor] parameter is mandatory, and defines the scale-factor to which the widget
  ///   is scaled , while hovering.
  ///
  ///  [duration] paramater is optional, and defines the duration of the hovering animation.
  ///   Defaults to Duration of seconds: 1.
  ///
  ///
  Widget increaseSizeOnHover(
    double scaleFactor, {
    Duration duration = const Duration(seconds: 1),
  }) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedContainer(
            duration: duration,
            curve: Curves.easeInOut,
            transformAlignment: Alignment.center,
            transform: isHovered
                ? Matrix4.diagonal3Values(scaleFactor, scaleFactor, 1.0)
                : Matrix4.diagonal3Values(1.0, 1.0, 1.0),
            child: this,
          ),
        );
      },
    );
  }
}

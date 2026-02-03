import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? largeMobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    this.mobile,
    this.largeMobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 500;

  static bool isLargeMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1080;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1080;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    if (size.width >= 1080) {
      return desktop;
    } else if (size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (size.width >= 500 && largeMobile != null) {
      return largeMobile!;
    } else {
      return mobile ?? desktop;
    }
  }
}

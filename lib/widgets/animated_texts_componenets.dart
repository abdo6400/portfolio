import 'package:flutter/material.dart';
import 'package:portfolio/utils/responsive.dart';
import 'package:portfolio/theme.dart';

class AnimatedImageContainer extends StatefulWidget {
  const AnimatedImageContainer({Key? key, this.height = 300, this.width = 300})
      : super(key: key);
  final double? width;
  final double? height;
  @override
  AnimatedImageContainerState createState() => AnimatedImageContainerState();
}

class AnimatedImageContainerState extends State<AnimatedImageContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
        final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;

        return RepaintBoundary(
          child: Transform.translate(
            offset: Offset(0, 4 * value),
            child: Container(
              height: widget.height!,
              width: widget.width!,
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                gradient: LinearGradient(
                  colors: [primary, accent],
                ),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.3),
                    offset: const Offset(-2, 0),
                    blurRadius: 15,
                  ),
                  BoxShadow(
                    color: accent.withOpacity(0.3),
                    offset: const Offset(2, 0),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(AppRadius.lg - 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.lg - 2),
                  child: Image.asset(
                    'assets/images/image.png',
                    height: Responsive.isLargeMobile(context)
                        ? MediaQuery.sizeOf(context).width * 0.2
                        : Responsive.isTablet(context)
                            ? MediaQuery.sizeOf(context).width * 0.14
                            : 200,
                    width: Responsive.isLargeMobile(context)
                        ? MediaQuery.sizeOf(context).width * 0.2
                        : Responsive.isTablet(context)
                            ? MediaQuery.sizeOf(context).width * 0.14
                            : 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_rounded,
                      size: 40,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

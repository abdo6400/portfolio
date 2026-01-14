import 'package:flutter/material.dart';
import '../../../res/responsive.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.prefix, required this.title});

  final String prefix;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   '$prefix ',
        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
        //       color: Colors.white,
        //       fontSize: !Responsive.isDesktop(context)
        //           ? Responsive.isLargeMobile(context)
        //               ? 20
        //               : 30
        //           : 50,
        //       fontWeight: FontWeight.bold),
        // ),
        ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ]).createShader(bounds);
          },
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: !Responsive.isDesktop(context)
                    ? Responsive.isLargeMobile(context)
                        ? 15
                        : 25
                    : 40,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

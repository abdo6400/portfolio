import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/information_controller.dart';

class MyPortfolioText extends StatelessWidget {
  const MyPortfolioText({super.key, required this.start, required this.end});
  final double start;
  final double end;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return TweenAnimationBuilder(
        tween: Tween(begin: start, end: end),
        duration: const Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Text(context.read<InformationController>().cv!.name,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold, height: 0, fontSize: value));
        },
      );
    });
  }
}

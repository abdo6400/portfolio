import 'package:flutter/material.dart';

import '../../../view model/controller.dart';

class NavigationTextButton extends StatelessWidget {
  final int index;
  final String text;

  const NavigationTextButton(
      {super.key, required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          itemScrollController.scrollTo(
              index: index,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutCubic);
        },
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }
}

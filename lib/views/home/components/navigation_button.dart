import 'package:flutter/material.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:provider/provider.dart';
import '../../../controllers/views_controller.dart';


class NavigationTextButton extends StatelessWidget {
  final int index;
  final String text;

  const NavigationTextButton(
      {super.key, required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewsController>(
      builder: (context, state, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  context.read<ViewsController>().changeView(index);
                  context.read<ViewsController>().itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOutCubic);
                },
                child: Text(
                  text,
                  style: state.currentView == index
                      ? Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.bold)
                      : Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(),
                )),
            if (state.currentView == index)
              const SizedBox(
                height: 20.0 / 2,
              ),
            if (state.currentView == index)
              AnimatedContainer(
                duration: Durations.extralong1,
                height: 2,
                width: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                )),
              )
          ],
        ).increaseSizeOnHover(1.1);
      },
    );
  }
}

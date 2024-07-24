import 'package:flutter/material.dart';
import 'package:portfolio/res/responsive.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback? onTap;
  const MenuButton({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 20.0 * 2.0,
        width: 20.0 * 2.0,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.pinkAccent.withOpacity(.5),
                  offset: const Offset(1, 1)),
              BoxShadow(
                  color: Colors.blue.withOpacity(.5),
                  offset: const Offset(-1, -1)),
            ]),
        child: const Center(
            child: Icon(
          Icons.menu,
          size: 20.0 * 1.2,
        )),
      ).increaseSizeOnHover(1.1),
    );
  }
}

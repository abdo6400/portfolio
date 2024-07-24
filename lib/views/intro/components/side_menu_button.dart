import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback? onTap;
  const MenuButton({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 20.0 * 2.0 * value,
            width: 20.0 * 2.0 * value,
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
            child: Center(
                child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                        colors: [Colors.pink, Colors.blue.shade900])
                    .createShader(bounds);
              },
              child: Icon(
                Icons.menu,
                size: 20.0 * 1.2 * value,
              ),
            )),
          ),
        );
      },
    );
  }
}

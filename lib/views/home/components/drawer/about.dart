import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/information_controller.dart';
import 'drawer_image.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          const DrawerImage(),
          const Spacer(),
          Text(
            context.read<InformationController>().cv!.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 20.0 / 4,
          ),
          const Text(
            'Flutter Developer & \nSoftware Engineering',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w200, height: 1.5),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

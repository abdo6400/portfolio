import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/deatail.dart';

import '../../../models/project_model.dart';

import 'image_viewer.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ImageViewer(context, projectList[index].image);
      },
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        duration: const Duration(milliseconds: 500),
        child: Detail(
          index: index,
        ),
      ),
    );
  }
}

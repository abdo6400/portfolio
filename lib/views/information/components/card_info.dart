import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/deatail.dart';
import '../../../models/project_model.dart';
import 'image_viewer.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({super.key, required this.index});
  final int index;

  @override
  _CardInfoState createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          ImageViewer(context, projectList[widget.index].image);
        },
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.translationValues(0, _isHovered ? -10 : 0, 0),
          child: Detail(
            index: widget.index,
          ),
        ),
      ),
    );
  }
}

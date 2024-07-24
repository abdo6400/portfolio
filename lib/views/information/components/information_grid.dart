import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/card_info.dart';
import '../../../components/flexible_wrap_base.dart';
import '../../../models/project_model.dart';

class InformationGrid extends StatelessWidget {
  const InformationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.04),
      child: FlexibleWrap(
        length: projectList.length, // Number of children to display
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: 10,
        builder: (int index) {
          return SizedBox(
            height: 300,
            width: 300,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(colors: [
                      Colors.pinkAccent,
                      Colors.blue,
                    ]),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.pink,
                        offset: Offset(-2, 0),
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.blue,
                        offset: Offset(2, 0),
                        blurRadius: 10,
                      ),
                    ]),
                child: CardInfo(index: index)),
          );
        },
        itemWidth: 300,
        direction: Axis.horizontal, // Direction to arrange the children
        alignment: WrapAlignment.start, // Alignment of children within a run
      ),
    );
  }
}

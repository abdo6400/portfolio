import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/card_info.dart';
import '../../../models/project_model.dart';

class InformationGrid extends StatelessWidget {
  final int crossAxisCount;
  final double ratio;
  const InformationGrid({super.key, this.crossAxisCount = 3, this.ratio = 1.3});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: projectList.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, childAspectRatio: ratio),
      itemBuilder: (context, index) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
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
            child: CardInfo(index: index));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/card_link.dart';

import '../../../models/project_model.dart';

import '../../../res/responsive.dart';

class Detail extends StatelessWidget {
  final int index;
  const Detail({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(alignment: Alignment.topCenter,child: Text(
          projectList[index].name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),),
        Responsive.isMobile(context) ?  const SizedBox(height: 20.0/2,) : const SizedBox(height: 20.0,),
        Text(projectList[index].description,style: const TextStyle(color: Colors.grey,height: 1.5),maxLines: size.width>700 && size.width< 750 ? 3:  size.width<470  ? 2  : size.width>600 && size.width<700 ?     6:  size.width>900 && size.width <1060 ? 6: 4 ,overflow: TextOverflow.ellipsis,),
        const Spacer(),
        ProjectLinks(index: index,),
        const SizedBox(height: 20.0/2,),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/views/home/components/drawer/contact_icons.dart';
import 'package:portfolio/views/home/components/drawer/personal_info.dart';
import 'knowledges.dart';
import 'about.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: Colors.white24,
      child: SingleChildScrollView(
        child: Column(
          children: [
            About(),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonalInfo(),
                  //MySKills(),
                  Knowledges(),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  ContactIcon(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

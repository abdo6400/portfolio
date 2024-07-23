import 'dart:async';
import 'package:flutter/material.dart';
import 'package:portfolio/controllers/information_controller.dart';

import 'package:portfolio/views/intro/components/animated_texts_componenets.dart';
import 'package:portfolio/views/splash/componenets/animated_loading_text.dart';
import 'package:provider/provider.dart';

import '../home/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () async{
      await context.read<InformationController>().loadInformation();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedImageContainer(
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 20.0,
            ),
            AnimatedLoadingText(),
          ],
        ),
      ),
    );
  }
}

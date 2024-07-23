
import 'package:flutter/material.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(
            'https://wa.me/${context.read<InformationController>().cv!.contactInformation.phone}'));
      },
      borderRadius: BorderRadius.circular(20.0 + 10),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0 * 2,
            vertical: 20.0 / 2,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(colors: [
                Colors.pink,
                Colors.blue.shade900,
              ]),
              boxShadow: const [
                BoxShadow(
                    color: Colors.blue,
                    offset: Offset(0, -1),
                    blurRadius: 20.0 / 4),
                BoxShadow(
                    color: Colors.red,
                    offset: Offset(0, 1),
                    blurRadius: 20.0 / 4),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.chat_sharp,
                color: Colors.greenAccent,
                size: 15,
              ),
              const SizedBox(width: 20.0 / 4),
              Text(
                'Whatsapp',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )).increaseSizeOnHover(1.05),
    );
  }
}

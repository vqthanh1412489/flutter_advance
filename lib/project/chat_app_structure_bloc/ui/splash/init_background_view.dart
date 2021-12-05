import 'package:flutter/material.dart';

class InitBackgroundView extends StatelessWidget {
  const InitBackgroundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Stack(
      children: [
        Positioned(
            right: -40,
            top: 50,
            child: CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.5),
              radius: 100,
            )),
        Positioned(
            right: 30,
            bottom: -70,
            child: CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.7),
              radius: 90,
            )),
        Positioned(
            left: -40,
            bottom: 120,
            child: CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.6),
              radius: 50,
            )),
      ],
    );
  }
}

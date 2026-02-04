import 'dart:math';

import 'package:flutter/material.dart';

Random randomize = Random();

class Roller extends StatefulWidget {
  const Roller({super.key});

  @override
  State<Roller> createState() {
    return _RollerState();
  }
}

class _RollerState extends State<Roller> {
  int currentDice = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentDice == 0
            ? Image.network(
                'https://i.guim.co.uk/img/media/1e3e5e2f6f3501befb629560ffe172a54ce3f016/139_98_2145_1287/master/2145.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=3a8ca8f6e9d7ff74ce25564dbeba3ca8',
                width: 300,
                height: 300,
              )
            : Image.asset(
                'assets/images/dice-$currentDice.png',
                width: 300,
                height: 300,
              ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              currentDice = randomize.nextInt(6) + 1;
            });
          },
          icon: Icon(Icons.arrow_forward),
          label: Text("Roll dice"),
        ),
      ],
    );
  }
}

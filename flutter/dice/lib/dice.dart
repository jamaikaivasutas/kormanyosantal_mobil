import 'package:dice/roller.dart';
import 'package:flutter/material.dart';

class Dice extends StatelessWidget {
  const Dice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Dice'), Roller()],
        ),
      ),
    );
  }
}

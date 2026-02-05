import 'package:flutter/material.dart';

class AllButton extends StatefulWidget {
  const AllButton({super.key});

  @override
  State<AllButton> createState() {
    return _AllButtonState();
  }
}

class _AllButtonState extends State<AllButton> {
  String firstButtons = "";
  String secondButtons = "";
  String thirdButtons = "";
  String fourthButtons = "";
  String fifthButtons = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(firstButtons),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  firstButtons = "The button has been pressed!";
                });
              },
              color: Colors.blue,
              child: Text("Show text"),
            ),

            MaterialButton(
              onPressed: () {
                setState(() {
                  firstButtons = "";
                });
              },
              color: Colors.blue,
              child: Text("Remove text."),
            ),
          ],
        ),
        Text(secondButtons),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  secondButtons = "The button has been pressed!";
                });
              },
              child: Text("Show text"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  secondButtons = "";
                });
              },
              child: Text("Remove text."),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomDetailsWidget extends StatelessWidget {
  const CustomDetailsWidget(
      {Key? key, required this.description, required this.label})
      : super(key: key);
  final String description;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black, fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                    text: description,
                    style:
                        const TextStyle(color: Colors.blueAccent, fontSize: 18))
              ]),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow textOverflow;
  HeadText(
      {Key? key,
      this.color = const Color(0xff332d2b),
      required this.text,
      this.size = 20,
      this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto'),
    );
  }
}

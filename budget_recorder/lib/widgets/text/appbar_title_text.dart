import 'package:flutter/material.dart';

class AppBarTitleText extends StatefulWidget {
  final String title;
  const AppBarTitleText({Key? key, required this.title}) : super(key: key);


  @override
  State<AppBarTitleText> createState() => _AppBarTitleTextState();
}

class _AppBarTitleTextState extends State<AppBarTitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

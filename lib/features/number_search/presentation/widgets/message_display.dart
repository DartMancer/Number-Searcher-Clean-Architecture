import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    return Container(
      alignment: Alignment.center,
      height: height / 3,
      child: Text(
        message,
        style: TextStyle(
          fontSize: 30,
          color: Colors.limeAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

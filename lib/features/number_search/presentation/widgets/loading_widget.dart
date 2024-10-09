import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    return Container(
      alignment: Alignment.center,
      height: height / 3,
      child: CircularProgressIndicator(color: Colors.limeAccent),
    );
  }
}

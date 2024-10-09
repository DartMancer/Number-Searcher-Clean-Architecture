import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.btnText,
    required this.isSearch,
  });

  final String btnText;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    return Text(
      btnText,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isSearch ? Theme.of(context).primaryColor : Colors.limeAccent,
        fontSize: 17,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'trivia_controls_button_text.dart';

class TriviaControlsButtonWidget extends StatelessWidget {
  const TriviaControlsButtonWidget({
    super.key,
    required this.btnText,
    required this.backgroundClr,
    required this.isSearch,
    required this.onPressed,
  });

  final String btnText;
  final Color backgroundClr;
  final bool isSearch;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(backgroundClr),
            side: WidgetStatePropertyAll<BorderSide>(
              BorderSide(width: 1, color: Colors.limeAccent),
            ),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          child: ButtonText(
            btnText: btnText,
            isSearch: isSearch,
          ),
        ),
      ),
    );
  }
}

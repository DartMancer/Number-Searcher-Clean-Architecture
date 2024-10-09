import 'package:flutter/material.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    super.key,
    required this.numberTrivia,
  });

  final NumberTrivia numberTrivia;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          numberTrivia.number.toString(),
          style: TextStyle(
            fontSize: 50,
            color: Colors.limeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          numberTrivia.text,
          style: TextStyle(
            fontSize: 25,
            color: Colors.limeAccent.shade200,
          ),
        ),
      ],
    );
  }
}

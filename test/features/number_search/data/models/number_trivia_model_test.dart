import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_searcher_clean_architecture/features/number_search/data/models/number_trivia_model.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTiviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test('shoud be a subclass of NumberTrivia entity', () async {
    // assert
    expect(tNumberTiviaModel, isA<NumberTrivia>());
  });

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia.json'));
          //act
          final result = NumberTriviaModel.fromJson(jsonMap);
          //assert
          expect(result, tNumberTiviaModel);
        },
      );
      test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia_double.json'));
          //act
          final result = NumberTriviaModel.fromJson(jsonMap);
          //assert
          expect(result, tNumberTiviaModel);
        },
      );
    },
  );
  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          //act
          final result = tNumberTiviaModel.toJson();
          //assert
          final expectedMap = {'text': 'Test Text', 'number': 1};
          expect(result, expectedMap);
        },
      );
    },
  );
}

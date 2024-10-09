import 'dart:convert';

import 'package:http/http.dart';
import 'package:number_searcher_clean_architecture/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/42 endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  final Client client;

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _getTriviaEndUrl(urlEnd: '$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaEndUrl(urlEnd: 'random');
  }

  Future<NumberTriviaModel> _getTriviaEndUrl({
    required String urlEnd,
  }) async {
    final response = await client.get(
      Uri.parse('http://numbersapi.com/$urlEnd'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

final class Empty extends NumberTriviaState {}

final class Loading extends NumberTriviaState {}

final class Loaded extends NumberTriviaState {
  const Loaded({required this.trivia});

  final NumberTrivia trivia;
}

final class Error extends NumberTriviaState {
  const Error({required this.message});

  final String message;
}

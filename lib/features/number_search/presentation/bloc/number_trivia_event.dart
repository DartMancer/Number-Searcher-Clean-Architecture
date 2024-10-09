part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  const GetTriviaForConcreteNumber(this.numberString);

  final String numberString;
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}

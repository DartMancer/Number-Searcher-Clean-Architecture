import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_searcher_clean_architecture/core/error/failures.dart';
import 'package:number_searcher_clean_architecture/core/usecases/usecase.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc({
    required this.concrete,
    required this.random,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      // Обрабатываем синхронно результат конвертера, но используем await для асинхронного вызова
      await inputEither.fold(
        (failure) async {
          emit(Error(message: invalidInputFailureMessage));
        },
        (integer) async {
          emit(Loading());
          final failureOrTrivia = await concrete(Params(number: integer));
          // Обязательно дожидаемся завершения
          _eitherLoadedOrErrorState(emit, failureOrTrivia);
        },
      );
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await random(NoParams());
      // Обязательно дожидаемся завершения
      _eitherLoadedOrErrorState(emit, failureOrTrivia);
    });
  }

  // Используем await внутри функции для правильного порядка выполнения emit
  Future<void> _eitherLoadedOrErrorState(
    Emitter<NumberTriviaState> emit,
    Either<Failure, NumberTrivia> failureOrTrivia,
  ) async {
    emit(
      failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trivia) => Loaded(trivia: trivia),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return serverFailureMessage;
      case CacheFailure _:
        return cacheFailureMessage;
      default:
        return 'Unexpected error';
    }
  }

  final GetConcreteNumberTrivia concrete;
  final GetRandomNumberTrivia random;
  final InputConverter inputConverter;
}

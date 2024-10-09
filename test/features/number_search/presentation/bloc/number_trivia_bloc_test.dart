import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_searcher_clean_architecture/core/error/failures.dart';
import 'package:number_searcher_clean_architecture/core/usecases/usecase.dart';
import 'package:number_searcher_clean_architecture/core/utils/input_converter.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/entities/number_trivia.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/usecases/get_random_number_trivia.dart';
import 'package:number_searcher_clean_architecture/features/number_search/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia])
@GenerateMocks([GetRandomNumberTrivia])
@GenerateMocks([InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.state, equals(Empty()));
  });
  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(text: 'Test Trivia', number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    void setUpMockGetConcreteNumberTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
    test(
      'should call the InputConverter to validate and convert the string to an usigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the inupt is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert
        final expected = [Error(message: invalidInputFailureMessage)];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
    );

    test(
      'should get data from concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // assert later
        final expected = [
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
    );
    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: serverFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
    );
    test(
      'should emit [Loading, Error] with proper message for the error when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
      },
    );
  });
  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(text: 'Test Trivia', number: 1);

    void setUpMockGetRandomNumberTriviaSuccess() =>
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

    test(
      'should get data from concrete use case',
      () async {
        // arrange
        setUpMockGetRandomNumberTriviaSuccess();
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockGetRandomNumberTriviaSuccess();
        // assert later
        final expected = [
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: serverFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
    test(
      'should emit [Loading, Error] with proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}

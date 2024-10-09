import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_searcher_clean_architecture/core/error/failures.dart';
import 'package:number_searcher_clean_architecture/core/usecases/usecase.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/entities/number_trivia.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/repositories/number_trivia_repository.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/usecases/get_random_number_trivia.dart';

import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetRandomNumberTrivia usecase;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(text: 'Test Text', number: 1);

  test(
    'should get trivia from the repository',
    () async {
      // arrange (Настройка мока)
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right<Failure, NumberTrivia>(tNumberTrivia));
      // act (Выполнение тестируемого кода)
      final result = await usecase(NoParams());
      // assert (Проверка результата)
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

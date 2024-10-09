import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:number_searcher_clean_architecture/core/error/failures.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/entities/number_trivia.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/repositories/number_trivia_repository.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'get_concrete_number_trivia_test.mocks.dart'; // Импорт сгенерированного файла

@GenerateMocks([NumberTriviaRepository])
void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetConcreteNumberTrivia usecase;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'Test Text', number: tNumber);

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange (Настройка мока)
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right<Failure, NumberTrivia>(tNumberTrivia));
      // act (Выполнение тестируемого кода)
      final result = await usecase(Params(number: tNumber));
      // assert (Проверка результата)
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

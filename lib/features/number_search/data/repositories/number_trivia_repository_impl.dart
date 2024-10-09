import 'package:dartz/dartz.dart';
import 'package:number_searcher_clean_architecture/core/error/exceptions.dart';
import 'package:number_searcher_clean_architecture/features/number_search/data/models/number_trivia_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';

typedef NumberTriviaResult = Future<Either<Failure, NumberTrivia>>;
typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  NumberTriviaResult getConcreteNumberTrivia(
    int number,
  ) async =>
      await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number),
      );

  @override
  NumberTriviaResult getRandomNumberTrivia() async => await _getTrivia(
        () => remoteDataSource.getRandomNumberTrivia(),
      );

  NumberTriviaResult _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

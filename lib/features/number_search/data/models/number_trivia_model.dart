import 'package:json_annotation/json_annotation.dart';
import 'package:number_searcher_clean_architecture/features/number_search/domain/entities/number_trivia.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);
}

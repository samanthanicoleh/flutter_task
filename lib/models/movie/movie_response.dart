import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'movie.dart';

part 'movie_response.freezed.dart';
part 'movie_response.g.dart';

// Class for the Movie Response object returned from the API
@freezed
@HiveType(typeId: 0)
class MovieResponse with _$MovieResponse {
  factory MovieResponse({
    @HiveField(0) required int page,
    @HiveField(1) required List<Movie> results,
    @HiveField(2) @JsonKey(name: 'total_pages') required int totalPages,
  }) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
}

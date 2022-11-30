import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../genre/genre.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

// Class for the Movie object
@freezed
@HiveType(typeId: 1)
class Movie with _$Movie {
  factory Movie({
    @HiveField(0) required int id,
    @HiveField(1) @JsonKey(name: 'original_title') required String originalTitle,
    @HiveField(2) required String overview,
    @HiveField(3) @JsonKey(name: 'vote_average') required double voteAverage,
    @HiveField(4) @JsonKey(name: 'poster_path') required String posterPath,
    @HiveField(5) @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @HiveField(6) @JsonKey(name: 'genres') List<Genre>? genres,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

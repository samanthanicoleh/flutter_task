import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'genre.freezed.dart';
part 'genre.g.dart';

// Class for the Genre object - used to map the id and name
@freezed
@HiveType(typeId: 2)
class Genre with _$Genre {
  factory Genre({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

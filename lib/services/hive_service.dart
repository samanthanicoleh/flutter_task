import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/genre/genre.dart';
import '../models/movie/movie.dart';

final hiveStateProvider = AsyncNotifierProvider<HiveProvider, void>(HiveProvider.new);

class HiveProvider extends AsyncNotifier<void> {
  late final Box<List<Movie>> cachedMoviesBox;
  late final Box<Movie> favouritedMoviesBox;

  @override
  FutureOr<void> build() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(MovieAdapter())
      ..registerAdapter(GenreAdapter());
    cachedMoviesBox = await Hive.openBox<List<Movie>>('cachedMoviesBox');
    favouritedMoviesBox = await Hive.openBox<Movie>('favouritedMoviesBox');
  }

  // Methods
  /// Cached Movies
  // Add cached movies to their box
  Future<void> addCachedMoviesToBox({required List<Movie> movies}) async => cachedMoviesBox.put(0, movies);

  // Retrieve cached movies from their box
  List<Movie> getCachedMoviesFromBox() => cachedMoviesBox.get(0) ?? [];

  /// Favourited Movies
  // Add favourite movies to their box
  Future<void> addFavouriteMoviesToBox({required Movie movie}) async => favouritedMoviesBox.put(movie.id, movie);

  // Remove favourite movie from their box
  Future<void> removeFavouriteMoviesToBox({required Movie movie}) async => favouritedMoviesBox.delete(movie.id);

  // Retrieve cached movies from their box
  List<Movie> getFavouriteMoviesFromBox() => favouritedMoviesBox.values.toList();

  bool checkIfBoxContains({required Movie movie}) => favouritedMoviesBox.containsKey(movie.id);
}

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/movie/movie.dart';
import '../../../repositories/movie_repository.dart';
import '../../../services/hive_service.dart';
import 'movie_genre_provider.dart';
import 'movie_pagination_provider.dart';

final movieStateProvider = AsyncNotifierProvider<MovieProvider, List<Movie>>(MovieProvider.new);

final favouriteMovieListProvider =
    StateProvider<List<Movie>>((ref) => ref.watch(hiveStateProvider.notifier).getFavouriteMoviesFromBox());

// Decided to use AsyncNotifier here
// Used StateNotifier in details_provider.dart
class MovieProvider extends AsyncNotifier<List<Movie>> {
  @override
  FutureOr<List<Movie>> build() async {
    await getGenres();
    return await getMovies();
  }

  Future<void> getGenres() async {
    final genreData = await ref.read(movieRepositoryProvider).getGenreNames();
    ref.read(genreListProvider.notifier).state = genreData;
  }

  Future<List<Movie>> getMovies() async {
    final currentMovieResults = state.value ?? [];

    final movieData = await ref.read(movieRepositoryProvider).getMovies(
          page: ref.read(currentPageProvider),
        );

    currentMovieResults.addAll(movieData.results);
    state = AsyncData(currentMovieResults);
    return movieData.results;
  }

  void favouriteMovie(Movie movie) {
    final isFavourite = ref.read(hiveStateProvider.notifier).checkIfBoxContains(movie: movie);

    if (!isFavourite) {
      ref.read(hiveStateProvider.notifier).addFavouriteMoviesToBox(movie: movie);
      ref.read(favouriteMovieListProvider.notifier).update((state) => [movie, ...state]);
    } else {
      ref.read(hiveStateProvider.notifier).removeFavouriteMoviesToBox(movie: movie);
      ref
          .read(favouriteMovieListProvider.notifier)
          .update((state) => state.where((element) => element.id != movie.id).toList());
    }
  }
}

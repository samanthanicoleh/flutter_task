import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/movie/movie.dart';
import '../../repositories/movie_repository.dart';

final movieDetailsStateProvider =
    StateNotifierProvider.autoDispose.family<MovieDetailsProvider, AsyncValue<Movie>, String>((ref, id) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieDetailsProvider(movieRepository, id);
});

// Decided to use StateNotifier here
// Used AsyncNotifier in movie_provider.dart
class MovieDetailsProvider extends StateNotifier<AsyncValue<Movie>> {
  final MovieRepository movieRepository;
  final String id;

  MovieDetailsProvider(this.movieRepository, this.id) : super(const AsyncLoading()) {
    getMovieDetails(id);
  }

  Future<void> getMovieDetails(String id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final movieData = await movieRepository.getMovieDetails(movieId: id);
      return movieData;
    });
  }
}

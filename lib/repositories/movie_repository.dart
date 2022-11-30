import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api.dart';
import '../models/genre/genre.dart';
import '../models/movie/movie.dart';
import '../models/movie/movie_response.dart';
import '../services/dio_service.dart';

final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepository(dioService: ref.watch(dioServiceProvider)),
);

class MovieRepository {
  final DioService dioService;

  MovieRepository({required this.dioService});

  // Endpoint that retrieves all movies
  Future<MovieResponse> getMovies({int page = 1}) => dioService.request(
        method: HttpMethod.get,
        url: AppEndpoints.popularMoviesUrl,
        parameters: {'page': page},
        token: ApiToken.token,
        builder: (data) => MovieResponse.fromJson(data),
      );

  // Endpoint that retrieves movie details
  Future<Movie> getMovieDetails({String movieId = '1'}) => dioService.request(
        method: HttpMethod.get,
        url: '${AppEndpoints.movieUrl}$movieId',
        token: ApiToken.token,
        builder: (data) => Movie.fromJson(data),
      );

  // Endpoint that retrieves all genre names
  Future<List<Genre>> getGenreNames() => dioService.request(
        method: HttpMethod.get,
        url: AppEndpoints.moviesGenreUrl,
        token: ApiToken.token,
        builder: (data) {
          final listGenres = <Genre>[];
          for (final genre in data['genres']) {
            listGenres.add(Genre.fromJson(genre));
          }
          return listGenres;
        },
      );
}

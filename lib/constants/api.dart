/// Class where all app endpoints are stored
class AppEndpoints {
  // Base urls
  static const baseUrl = 'https://api.themoviedb.org/3/';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';

  // Endpoints
  static const movieUrl = 'movie/';
  static const popularMoviesUrl = 'movie/popular';
  static const moviesGenreUrl = 'genre/movie/list';
}

// Could use https://pub.dev/packages/flutter_dotenv to hide the token, but hardcoded it for this task
class ApiToken {
  static const token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4';
}

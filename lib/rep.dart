import 'dart:async';
import 'package:dio/dio.dart';
import 'package:isolate_manager/isolate_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_project/functions.dart';

part 'rep.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) {
  return MovieRepository();
}

@riverpod
class AsyncMovieNotifier extends _$AsyncMovieNotifier {
  
  @override
  FutureOr<MovieResponse> build() async {
    return _init('https://api.themoviedb.org/3/movie/top_rated');
  }

  FutureOr<MovieResponse> _init(String movieLink) async {
    final movieRep = ref.watch(movieRepositoryProvider);
    final movieList = await movieRep.getMovies(movieLink);
    return movieList;
  }

  void fetchData(String movieLink) async {
    state = const AsyncLoading();
    final movieRep = ref.watch(movieRepositoryProvider);
    final movieList = await movieRep.getMovies(movieLink);
    state = AsyncData(movieList);
  }

Future<void> fetchDataFromIsolate(String url) async {
  state = const AsyncLoading();
  final isolateManager = IsolateManager.create(fetchMovieList, workerName: 'worker' ,concurrent: 2, isDebug: true);
  final json = await isolateManager.compute(url);
  final jsonMap = json.data as Map<String, dynamic>;
  final result = MovieResponse.fromJson(jsonMap);
  state = AsyncData(result);
  await isolateManager.stop();
}

  void refreshData(){
    ref.invalidateSelf();
  }
}




class MovieRepository {
  Dio dio = Dio();
  static const String _apiKey = 'a72aeb65f93911542ff66814d78affd0';
  Map<String, String> headers = {
    'Authorization': 'a72aeb65f93911542ff66814d78affd0',
    'accept': 'application/json'
  };

  Future<MovieResponse> getMovies(String moviesLink) async {
    print('try');
    final dynamic json = await Dio().get(moviesLink, queryParameters: {
      'api_key': _apiKey,
      'language': 'en-US',
      'page': 1,
    });
    print('get');
    final jsonMap = json.data as Map<String, dynamic>;
    final result = MovieResponse.fromJson(jsonMap);
    Timer(const Duration(seconds: 0), () => print('ready'));
    return result;
  }
}

class MovieResponse {
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;
  final int page;

  MovieResponse({
    required this.movies,
    required this.totalPages,
    required this.totalResults,
    required this.page,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

class Movie {
  final String? posterPath;
  final bool adult;
  final String overview;
  final DateTime? releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  Movie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

DateTime? parseMovieDateFromString(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return null;
  return DateTime.tryParse(rawDate);
}

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      movies: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
      page: json['page'] as int,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'page': instance.page,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      posterPath: json['poster_path'] as String?,
      adult: json['adult'] as bool,
      overview: json['overview'] as String,
      releaseDate: parseMovieDateFromString(json['release_date'] as String?),
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      id: json['id'] as int,
      originalTitle: json['original_title'] as String,
      originalLanguage: json['original_language'] as String,
      title: json['title'] as String,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'poster_path': instance.posterPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.releaseDate?.toIso8601String(),
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'video': instance.video,
      'vote_average': instance.voteAverage,
    };

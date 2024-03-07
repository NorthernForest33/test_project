import 'dart:async';
import 'package:dio/dio.dart';
import 'package:isolate_manager/isolate_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_project/functions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rep.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) {
  return MovieRepository();
}

@riverpod
class AsyncMovieNotifier extends _$AsyncMovieNotifier {
  
  @override
  FutureOr<MovieResponse> build() async {
    return _init(MovieListRequestParametrs.popularMovies);
  }

  FutureOr<MovieResponse> _init(Map<String, String> movieParam) async {
    final movieRep = ref.watch(movieRepositoryProvider);
    final movieList = await movieRep.getMovies(movieParam);
    return movieList;
  }

  void fetchData(Map<String, String> movieParam) async {
    state = const AsyncLoading();
    final movieRep = ref.watch(movieRepositoryProvider);
    final movieList = await movieRep.getMovies(movieParam);
    state = AsyncData(movieList);
  }

Future<void> fetchDataFromIsolate(Map<String, String> movieParam) async {
  state = const AsyncLoading();
  final isolateManager = IsolateManager.create(fetchMovieList, workerName: 'worker' ,concurrent: 2, isDebug: true);
  final json = await isolateManager.compute(movieParam);
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
  Map<String, String> headers = {
    'accept': 'application/json',
    'X-API-KEY': '49BHQRJ-YJFMW5K-PPSYSZN-S2NRJNC'
  };

  Future<MovieResponse> getMovies(
      Map<String, String> queryParameters) async {
    print('send');
    final dynamic json = await Dio().get('https://api.kinopoisk.dev/v1.3/movie',
        options: Options(headers: headers), queryParameters: queryParameters);
    final jsonMap = json.data as Map<String, dynamic>;
    final result = MovieResponse.fromJson(jsonMap);
    print('get');
    return result;
  }

}

class MovieListRequestParametrs {
  static const Map<String, String> popularMovies = {
    'premiere.world': '15.10.2022-15.10.2023',
    'sortFields': 'votes.kp',
    'sortType': '-1',
    'limit': '20'
  };

  static const Map<String, String> releasedSoonMovies = {
    'poster.url': '!null',
    'status': 'announced',
    'sortFields': 'votes.await',
    'sortType': '-1',
    'limit': '20'
  };

  static const Map<String, String> mostRatedMovie = {
    'sortFields': 'rating.kp',
    'sortType': '-1',
    'limit': '20'
  };

  Map<String, String> searchRequstParametrs(String query, String page) =>
      {'page': page, 'limit': '20', 'name': query};
}

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'docs')
  final List<Movie> movies;
  final int total;
  final int limit;
  final int page;
  final int pages;

  MovieResponse({
    required this.movies,
    required this.total,
    required this.limit,
    required this.page,
    required this.pages,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

@JsonSerializable()
class Movie {
  final int id;
  final String? name;
  final String? alternativeName;
  final String? enName;
  final String type;
  final int? typeNumber;
  final int? year;
  final String? description;
  final String? shortDescription;
  final String? slogan;
  final String? status;
  final int? movieLength;
  final int? ageRating;
  final int? top10;
  final int? top250;

  Movie({
    required this.id,
    required this.name,
    required this.alternativeName,
    required this.enName,
    required this.type,
    required this.typeNumber,
    required this.year,
    required this.description,
    required this.shortDescription,
    required this.slogan,
    required this.status,
    required this.movieLength,
    required this.ageRating,
    required this.top10,
    required this.top250,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
    
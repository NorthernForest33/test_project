// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      movies: (json['docs'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      limit: json['limit'] as int,
      page: json['page'] as int,
      pages: json['pages'] as int,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'docs': instance.movies,
      'total': instance.total,
      'limit': instance.limit,
      'page': instance.page,
      'pages': instance.pages,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int,
      name: json['name'] as String?,
      alternativeName: json['alternativeName'] as String?,
      enName: json['enName'] as String?,
      type: json['type'] as String,
      typeNumber: json['typeNumber'] as int?,
      year: json['year'] as int?,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      slogan: json['slogan'] as String?,
      status: json['status'] as String?,
      movieLength: json['movieLength'] as int?,
      ageRating: json['ageRating'] as int?,
      top10: json['top10'] as int?,
      top250: json['top250'] as int?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alternativeName': instance.alternativeName,
      'enName': instance.enName,
      'type': instance.type,
      'typeNumber': instance.typeNumber,
      'year': instance.year,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'slogan': instance.slogan,
      'status': instance.status,
      'movieLength': instance.movieLength,
      'ageRating': instance.ageRating,
      'top10': instance.top10,
      'top250': instance.top250,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$movieRepositoryHash() => r'd984537688258d07ee4e7ce71288598e4f92b737';

/// See also [movieRepository].
@ProviderFor(movieRepository)
final movieRepositoryProvider = AutoDisposeProvider<MovieRepository>.internal(
  movieRepository,
  name: r'movieRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$movieRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MovieRepositoryRef = AutoDisposeProviderRef<MovieRepository>;
String _$asyncMovieNotifierHash() =>
    r'32c3d118cf85b27848c9a0d4c51605e0e277ebdf';

/// See also [AsyncMovieNotifier].
@ProviderFor(AsyncMovieNotifier)
final asyncMovieNotifierProvider = AutoDisposeAsyncNotifierProvider<
    AsyncMovieNotifier, MovieResponse>.internal(
  AsyncMovieNotifier.new,
  name: r'asyncMovieNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$asyncMovieNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AsyncMovieNotifier = AutoDisposeAsyncNotifier<MovieResponse>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

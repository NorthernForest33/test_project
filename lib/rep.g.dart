// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rep.dart';

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
    r'de35068f3b618e1306a42cb0cd66416bc0a302da';

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

import 'dart:async';
import 'package:dio/dio.dart';

@pragma('vm:entry-point')
Future<dynamic> fetchMovieList(Map<String, String> movieParam) async {
  print('worker work!');
  final dynamic json = await Dio().get('https://api.kinopoisk.dev/v1.3/movie',
      options: Options(headers: {
        'accept': 'application/json',
        'X-API-KEY': '49BHQRJ-YJFMW5K-PPSYSZN-S2NRJNC'
      }),
      queryParameters: movieParam);
  print('worker data get!!!');
  return json;
}

import 'dart:async';
import 'package:dio/dio.dart';


@pragma('vm:entry-point')
Future<dynamic> fetchMovieList(String url) async {
  print('worker work!');
      final dynamic json = await Dio().get(url, queryParameters: {
      'api_key': 'a72aeb65f93911542ff66814d78affd0',
      'language': 'en-US',
      'page': 1,
    });
  print('worker data get!!!');
  return json;
}


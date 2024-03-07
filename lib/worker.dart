// ignore_for_file: avoid_web_libraries_in_flutter, depend_on_referenced_packages
import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

import 'package:isolate_manager/isolate_manager.dart';
import 'package:js/js.dart' as pjs;
import 'package:js/js_util.dart' as js_util;

import '../functions.dart';

@pjs.JS('self')
external dynamic get globalScopeSelf;

main() {
  callbackToStream('onmessage', (html.MessageEvent e) {
    return js_util.getProperty(e, 'data');
  }).listen((message) async {
    final Completer completer = Completer();
    completer.future.then(
          (value) => jsSendMessage(value),
      onError: (err, stack) =>
          jsSendMessage(IsolateException(err, stack).toJson()),
    );
    try {
      completer.complete(worker(message));
    } catch (err, stack) {
      jsSendMessage(IsolateException(err, stack).toJson());
    }
  });
}

FutureOr<dynamic> worker(dynamic message) {
  return fetchMovieList(message);
}

Stream<T> callbackToStream<J, T>(
    String name, T Function(J jsValue) unwrapValue) {
  var controller = StreamController<T>.broadcast(sync: true);
  js_util.setProperty(js.context['self'], name, js.allowInterop((J event) {
    controller.add(unwrapValue(event));
  }));
  return controller.stream;
}

void jsSendMessage(dynamic m) {
  js.context.callMethod('postMessage', [m]);
}
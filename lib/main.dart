import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_project/rep.dart';


void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {

  @override
  Widget build(BuildContext context) {
    var movieData = ref.watch(asyncMovieNotifierProvider);
    const newMovieParam = MovieListRequestParametrs.mostRatedMovie;
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
      TextButton(
          onPressed: () {
            ref.read(asyncMovieNotifierProvider.notifier)
                .fetchDataFromIsolate(newMovieParam);
          },
          child: Container(height: 100, width: 100, color: Colors.red)),
      Expanded(
        child: movieData.when(
            data: (movieData) {
              List<Movie> movieList = movieData.movies;
              return ListView.builder(
                  itemExtent: 80,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                          title: Text(
                            movieList[index].name ?? 'name',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            movieList[index].alternativeName ?? 'alt Name',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ));
                  });
            },
            error: (error, s) => Text(error.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
      ),
    ])));
  }
}


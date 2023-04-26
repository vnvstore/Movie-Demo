import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/core/constant.dart';
import 'package:dio/dio.dart';

Future<List<MovieObj>?> fetchMovies() async {
  List<MovieObj> movies = [];

  try {

    Response response = await Dio().get('https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY');

    for (var movie in response.data["results"]) {
      MovieObj movieObj = MovieObj.fromJson(movie);
      movies.add(movieObj);
    }
    movies.sort((a, b) {
      return a.title.compareTo(b.title);
    });

    List<MovieObj> result = movies.toSet().toList();
    return  result;
  } catch (e) {
    print(e);
  }
  return null;
}

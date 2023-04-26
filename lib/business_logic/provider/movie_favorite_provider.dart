import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/business_logic/model/movie_favorite.dart';
import 'package:MovieDemo/business_logic/repository/movie_favorite_repository.dart';
import 'package:MovieDemo/business_logic/services/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieFavoriteProvider = FutureProvider<List<MovieObj>?>((ref) async {
  List<MovieObj>? movies = await fetchMovies();
  List<MovieFavorite>? movieFavorites = await MovieFavoriteRepository().getList();
  if(movieFavorites != null && movieFavorites.length > 0){
    List<int> movieIds = [];
    for(MovieFavorite obj in movieFavorites){
      movieIds.add(obj.movie_id!);
    }
    List<MovieObj>? filteredMovies  = movies?.where((item) {
      return movieIds.contains(item.id);
    }).toList();
    return filteredMovies;
  }
  return movies;
});

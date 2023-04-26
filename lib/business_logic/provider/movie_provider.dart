import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/business_logic/services/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider = FutureProvider<List<MovieObj>?>((ref) async {
  return await fetchMovies();
});

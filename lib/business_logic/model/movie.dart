
import 'dart:convert';

MovieObj MovieObjFromJson(String str) => MovieObj.fromJson(json.decode(str));

String MovieObjToJson(MovieObj data) => json.encode(data.toJson());

class MovieObj {
  MovieObj({
    required this.id,
    required this.title,
    required this.release_date,
    required this.poster_path,
    required this.overview

  });

  int id;
  final String title;
  final String release_date;
  final String poster_path;
  final String overview;




  factory MovieObj.fromJson(Map<String, dynamic> json) => MovieObj(
    id: json["id"]??"",
    title: json["title"]??"",
    release_date: json["release_date"]??"",
    poster_path: json["poster_path"]??"",
    overview: json["overview"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "year": release_date,
    "isFavorite": poster_path,
    "rating": overview,

  };
}

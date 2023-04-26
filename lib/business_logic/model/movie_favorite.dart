
class MovieFavorite {


  int? id;
  int? movie_id;

  MovieFavorite(
      {this.id,
      this.movie_id,
      });

  factory MovieFavorite.fromDatabaseJson(Map<String, dynamic> data) {

    return MovieFavorite(

      id: data["id"] ?? 0,
      movie_id: data["movie_id"] ?? 0,

    );
  }

  Map<String, dynamic> toDatabaseJson() {

    Map<String, dynamic> map = new Map();

    map["id"] = this.id;
    map["movie_id"] = this.movie_id;


    return map;
  }


}

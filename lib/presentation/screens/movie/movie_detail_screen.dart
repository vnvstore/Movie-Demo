import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/business_logic/model/movie_favorite.dart';
import 'package:MovieDemo/business_logic/repository/movie_favorite_repository.dart';
import 'package:MovieDemo/business_logic/utils/helper.dart';
import 'package:MovieDemo/core/constant.dart';
import 'package:MovieDemo/presentation/screens/movie/movie_favorite_screen.dart';
import 'package:MovieDemo/presentation/widgets/custom_loading_spin_kit_ring.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MovieDetailScreen extends StatefulWidget {

  final MovieObj movieObj;
  MovieDetailScreen({required this.movieObj});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();


}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  MovieFavoriteRepository repository = MovieFavoriteRepository();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    intData();
  }

  intData() async{
    MovieFavorite?  movieFavorite = await this.repository.getByField("movie_id",this.widget.movieObj.id);
    if(movieFavorite != null ){
      setState(() {
        isFavorite = true;
      });
    }
  }

  saveFavorite() async {

    await this.repository.insert(MovieFavorite(movie_id: this.widget.movieObj.id));

    setState(() {
      isFavorite = true;
    });
  }

  removeFavorite() async {

    await this.repository.deleteByField("movie_id",this.widget.movieObj.id);

    setState(() {
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shadowColor: Colors.transparent.withOpacity(0.1),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            leading: Padding(
              padding: EdgeInsets.only(left: 3),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            automaticallyImplyLeading: false,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 200.0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 3),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      (!isFavorite) ? saveFavorite() : removeFavorite();
                    });
                  },
                  icon: Icon((isFavorite)
                      ? Icons.bookmark_sharp
                      : Icons.bookmark_border_sharp),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(""),
              background: SafeArea(
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  placeholder: (context, url) => SafeArea(
                    child: Container(
                      height: 22,
                      child: CustomLoadingSpinKitRing(
                          loadingColor: kMainGreenColor),
                    ),
                  ),
                  imageUrl: Helper.getMovieImageFullPath(this.widget.movieObj.poster_path),
                  errorWidget: (context, url, error) => SafeArea(
                    child: Container(
                      height: 22,
                      child: CustomLoadingSpinKitRing(
                          loadingColor: kMainGreenColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Wrap(
                        children: [
                          Text(
                            "${this.widget.movieObj.title} ",
                            style: kDetailScreenBoldTitle,
                          ),
                          Text("${this.widget.movieObj.release_date}",
                            style: kDetailScreenRegularTitle,
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 1),
                  ],
                ),
                if (this.widget.movieObj.overview != "")
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3, vertical: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 1,
                              left: 1,
                              bottom: 1,
                            ),
                            child: Container(
                              child: Text(kStoryLineTitleText,
                                  style: kSmallTitleTextStyle),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 1,
                                  left: 1,
                                  top: 1,
                                  bottom: 4),
                              child: Text(
                                this.widget.movieObj.overview,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFC9C9C9)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      )
    );
  }
}

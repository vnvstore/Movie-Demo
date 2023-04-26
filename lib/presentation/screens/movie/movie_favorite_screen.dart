import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/business_logic/model/movie_favorite.dart';
import 'package:MovieDemo/business_logic/provider/movie_favorite_provider.dart';
import 'package:MovieDemo/business_logic/provider/movie_provider.dart';
import 'package:MovieDemo/business_logic/repository/movie_favorite_repository.dart';
import 'package:MovieDemo/business_logic/utils/helper.dart';
import 'package:MovieDemo/core/constant.dart';
import 'package:MovieDemo/presentation/screens/movie/movie_detail_screen.dart';
import 'package:MovieDemo/presentation/widgets/custom_loading_spin_kit_ring.dart';
import 'package:MovieDemo/presentation/widgets/movie_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieFavoriteScreen extends StatefulWidget {

  MovieFavoriteScreen({Key? key, required this.movies}) : super(key: key);
  List<MovieObj> movies;

  @override
  State<MovieFavoriteScreen> createState() => _MovieFavoriteScreenState();


}

class _MovieFavoriteScreenState extends State<MovieFavoriteScreen> {
  String title ="Favorite Movies";

  List<MovieObj>? favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    initData();

  }

  initData() async{
    List<MovieFavorite>? movieFavorites = await MovieFavoriteRepository().getList();
    if(movieFavorites != null && movieFavorites.length > 0){
      List<int> movieIds = [];
      for(MovieFavorite obj in movieFavorites){
        movieIds.add(obj.movie_id!);
      }
      if(movieIds.length > 0){
        favoriteMovies  = this.widget.movies.where((item) {
          return movieIds.contains(item.id);
        }).toList();
        setState(() {

        });
      }

    }

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:  Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.black87,
        ),

        body: ListView.builder(
          itemCount: favoriteMovies!.length,
          itemBuilder: (context, index) {
            final item = favoriteMovies![index];
            return Dismissible(
              // Each Dismissible must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(item.id.toString()),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) async{

                await MovieFavoriteRepository().deleteByField("movie_id", item.id);
                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item dismissed')));
                initData();
              },
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(item.title),
                leading: Container(
                  width: 50,
                  height: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SafeArea(
                      child: Container(
                        height: 22,
                        child: CustomLoadingSpinKitRing(
                            loadingColor: kMainGreenColor),
                      ),
                    ),
                    imageUrl: Helper.getMovieImageFullPath(item.poster_path),
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
            );
          },
        ),
      ),
    );

  }
}
/*

class MovieFavoriteScreen extends ConsumerWidget {

  MovieFavoriteScreen({Key? key}): super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final movies = ref.watch(movieFavoriteProvider);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kBlackBg, kWhiteBg],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Column(
            children: [
              AppBar(backgroundColor: Colors.transparent,title: Text("Favorite Movies"),),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: movies.when(
                  data: (data) => OrientationBuilder(builder: (context, orientation) {

                    return GridView.count(
                      crossAxisCount: 3,
                      children: List.generate(data!.length, (index) {
                        return GestureDetector(

                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen( movieObj: data![index]),
                                )),


                            child: MovieCard(
                                size: size,
                                data: data![index]
                            )
                        );
                      }),
                    );
                  }),
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                  loading: () => Lottie.asset(kLoading, width: size.width / 4),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
*/

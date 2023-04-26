import 'package:MovieDemo/business_logic/model/movie_favorite.dart';
import 'package:MovieDemo/business_logic/provider/movie_favorite_provider.dart';
import 'package:MovieDemo/business_logic/provider/movie_provider.dart';
import 'package:MovieDemo/core/constant.dart';
import 'package:MovieDemo/presentation/screens/movie/movie_detail_screen.dart';
import 'package:MovieDemo/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';


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


import 'package:MovieDemo/business_logic/provider/movie_provider.dart';
import 'package:MovieDemo/core/constant.dart';
import 'package:MovieDemo/presentation/screens/movie/movie_detail_screen.dart';
import 'package:MovieDemo/presentation/widgets/appbar/main_appbar.dart';
import 'package:MovieDemo/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MovieListScreen extends ConsumerWidget {

  MovieListScreen({Key? key}): super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final movies = ref.watch(movieProvider);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
            child: movies.when(
              data: (data) => Column(
                children: [
                  MainAppbar(
                    widget: Container(),
                    movies: data!,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: OrientationBuilder(builder: (context, orientation) {
                      return GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(data!.length, (index) {
                          return GestureDetector(

                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen( movieObj: data[index]),
                                  )),


                              child: MovieCard(
                                  size: size,
                                  data: data[index]
                              )
                          );
                        }),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => Center(
                child: Lottie.asset(kLoading, width: size.width / 4),
              ),
            ),


          ),
        ),
      ),
    );
  }

}


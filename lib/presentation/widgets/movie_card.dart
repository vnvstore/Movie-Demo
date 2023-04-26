import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/business_logic/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:MovieDemo/core/constant.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {Key? key,
        required this.size,
        required this.data,
        })
      : super(key: key);
  final size;
  final MovieObj data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              errorWidget: (context, url, error) => Center( child: SizedBox(width: 50, child: Lottie.asset(kNotFound, width: 60))
               ),

              imageBuilder: (context, imageProvider) => Container(
                height: size.width / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                ),
              ),

              placeholder: (context, url) => Center( child: SizedBox(width: 50, child: Lottie.asset(kLoading, width: 60))),
              imageUrl: Helper.getMovieImageFullPath(data.poster_path),

              // progressIndicatorBuilder: (context, url, progress) => ProgressIndicator(value: progress.progress,),
              fit: BoxFit.contain,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Text(
                data.title,
                overflow: TextOverflow.ellipsis,
                style:
                const TextStyle(color: Colors.white, fontSize: 12),
              ),
              //height: 50,
              height: 35,
              decoration: BoxDecoration(
                  //color: Colors.grey.shade900,
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
            ),
          ],
        ));
  }
}
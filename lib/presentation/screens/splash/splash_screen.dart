import 'dart:async';
import 'package:MovieDemo/presentation/screens/movie/movie_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:MovieDemo/core/constant.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void changePage() {
    Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  MovieListScreen(),
            ));
        timer.cancel();
      },


    );
  }

  @override
  void initState() {
    changePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(kSplashLoading,width: width / 4),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "its time to movies",
              style: TextStyle(fontSize: 20, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}

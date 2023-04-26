import 'package:MovieDemo/business_logic/model/movie.dart';
import 'package:MovieDemo/presentation/screens/movie/movie_favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';


final forwardProvider = StateProvider<bool>((ref) {
  return true;
});

class MainAppbar extends StatefulWidget {
   MainAppbar({
    Key? key,
    required this.widget,
    required this.movies,
    this.havSettingBtn=true

  }) : super(key: key);
  final Widget widget;
  final bool havSettingBtn;
  List<MovieObj> movies;

  @override
  State<MainAppbar> createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void changePage(PageController pageController, int index) async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      index == 0
          ? pageController.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.bounceOut)
          : pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.bounceOut);
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff6A359C), Color(0xff9969C7)])),
                child: const Icon(
                  LineIcons.play,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Movie Demo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 21),
                ),
              ),

            ],
          ),
          widget.havSettingBtn?Consumer(builder: (context, ref, child) {

            return GestureDetector(
                onTap: () async{

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieFavoriteScreen(movies: this.widget.movies),
                      ));
                },
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: Colors.grey)),
                    child: Icon(Icons.bookmark_outline, color: Colors.white,),));
          }):Container()
        ],
      ),
    );
  }
}

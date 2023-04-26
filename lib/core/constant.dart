import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String API_KEY =  "7087a39e3c95bb111d4fc195806d62aa";

const kFavoriteRemovedText = "Movie removed from Favorites";
const kFavoriteAddedText = "Movie added to Favorites";
const kStoryLineTitleText = "Plot summary";

const Color kBlackBg = Color(0xff1c1829);
const Color kWhiteBg = Color(0xff262436);
const Color kPurple = Color(0xff9c4af5);
const Color kGray = Color(0xff262433);

const kLoading = ("assets/animation/loading.json");
const kSplashLoading = ("assets/animation/splash_loading.json");
const kNotFound = ("assets/animation/not_found.json");
const kTvLoading = ("assets/animation/tv_loading.json");

const kPrimaryColor = Color(0xFF101010);
const kMainGreenColor = Color(0xFF37A45E);
final kSmallTitleTextStyle = TextStyle(fontSize: 18,color: Colors.white);
final kDetailScreenBoldTitle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final kDetailScreenRegularTitle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);

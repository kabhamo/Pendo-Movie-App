import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/widgets/toprated.dart';
import 'package:movie_app_flutter/widgets/trending.dart';
import 'package:movie_app_flutter/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:movie_app_flutter/utils/appbar.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //to disable the debug banner
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '8039618a6c1dba3133ec5ee188374b77';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MDM5NjE4YTZjMWRiYTMxMzNlYzVlZTE4ODM3NGI3NyIsInN1YiI6IjYxM2JjN2VmMDhjZjg3MDA2MjA5ZjVkMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QzLn0HI4LlI88P-oNQu09-PucJ9pp3xAOmeMSFy-r0A';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending(); //getting a map<String> of trending movies
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated(); //getting a map<String> of movies
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar(); //getting a map<String> of TV movies
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
         appBar: AppBar(
           flexibleSpace:TransparentAppBarPage(name: 'Pendo App',),
         ),
        body: ListView(
          children: [
            TV(tv: tv),
            TrendingMovies(
              trending: trendingmovies,
            ),
            TopRatedMovies(
              toprated: topratedmovies,
            ),
          ],
        ));
  }
}

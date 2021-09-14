import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app_flutter/movie/movie.dart';
class MovieApi {
  static const apikey = '8039618a6c1dba3133ec5ee188374b77';

  static Future<List<String>> moviesearch({@required String query}) async {
    List<String> json1 = [];
    final url =
        'https://api.themoviedb.org/3/search/tv?api_key=8039618a6c1dba3133ec5ee188374b77&language=en-US&query=$query';
    final response = await http.get(url);
    final body = json.decode(response.body);
    final name =  body['results'][0]['name'];
    json1.add(name);
    return json1;
    }

  static Future<Movie> getMovie({@required String movie}) async {
    final url =
        'https://api.themoviedb.org/3/search/tv?api_key=8039618a6c1dba3133ec5ee188374b77&language=en-US&query=$movie';
    final response = await http.get(url);
    final body = json.decode(response.body);
    return _convert(body);
  }

  static Movie _convert(json) {
    final img = 'https://image.tmdb.org/t/p/w500' + json['results'][0]['backdrop_path'];
    final release_date = json['results'][0]['first_air_date'];
    final name =  json['results'][0]['name'];
    final overview = json['results'][0]['overview'];
    final id = (json['results'][0]['id']).toString();
    final vote_average = (json['results'][0]['vote_average']);
      return Movie(
          img1: img,
          release_date1: release_date,
          name1: name,
          overview1: overview,
          id1: id,
          vote_average1: vote_average.toString(),
      );
  }
}
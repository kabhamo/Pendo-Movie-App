import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/data/movies_api.dart';
import 'package:movie_app_flutter/movie/movie.dart';
import 'dart:ui';

class TransparentAppBarPage extends StatelessWidget {
  final String name ;
  const TransparentAppBarPage({this.name});

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      title: ModifiedText(text:name,size: 30,).lobster(context),
      centerTitle: true,
      leading: BackButton(),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async{
            showSearch(context: context, delegate: SearchMovie());
          },
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      backgroundColor: Colors.transparent, // Colors.white.withOpacity(0.1),
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.black],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
      ),
    ),
  );

}

class SearchMovie extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) =>
      [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<Movie>(
        future: MovieApi.getMovie(movie: query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                );
              } else {
                return buildResultSuccess(snapshot.data);
              }
          }
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) =>
      Container(
        color: Color(0xff11052C),
        child: FutureBuilder<List<String>>(
          future: MovieApi.moviesearch(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty){ return buildNoSuggestions();}

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data.isEmpty) {
                  return buildNoSuggestions();
                }
                else {
                  return buildSuggestionsSuccess(snapshot.data);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      );

  Widget buildSuggestionsSuccess(List<String> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);
          return ListTile(
            onTap: () {
              query = suggestion;
              // Show Results
              showResults(context);
            },
            leading: Icon(Icons.local_movies_outlined),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );


  Widget buildResultSuccess(Movie movie) =>
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFFFFADAD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(64),
          children: [
            Container(
              width: 150,
              height: 250,
              child: Image.network(movie.img1,fit: BoxFit.cover),
            ),
            SizedBox(height: 15),

            Container(  padding: EdgeInsets.all(10),
                child: ModifiedText(text: '⭐ Average Rating - ' + movie.vote_average1, color:Color(0xFFFFB319))),

            Container(
                padding: EdgeInsets.all(10),
                child: ModifiedText(
                    text: movie.name1 != null ? movie.name1 : 'Not Loaded', size: 24)),

            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.only(left: 10),
                child:
                ModifiedText(text: 'Overview', size: 24)),

            Row(
              children: [
                Flexible(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: ModifiedText(text: movie.overview1, size: 18)),
                ),
              ],
            )
          ],
        ),
      );

  // Widget buildDegrees(Movie movie) {
  //
  // }
}

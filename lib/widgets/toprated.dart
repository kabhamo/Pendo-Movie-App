import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key key, this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: 'Top Rated Movies',
            size: 26,
          ),
          SizedBox(height: 8),
          Container(
              height: 290,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toprated.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      hoverColor: Color(0x2FFFADAD),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                  name: toprated[index]['title'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      toprated[index]['backdrop_path'],
                                  description: toprated[index]['overview'],
                                  vote: toprated[index]['vote_average']
                                      .toString(),
                                  launch_on: toprated[index]
                                  ['release_date'],
                                )));
                      },
                      child: toprated[index]['title'] != null ?
                      Container(
                        width: 160,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                 image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          toprated[index]['poster_path'] , scale: 3.6),
                                ),
                              ),
                              height: 220,
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: ModifiedText(
                                  size: 16,
                                  text: toprated[index]['title'] != null
                                      ? toprated[index]['title']
                                      : 'Error').build(context),
                            ),
                          ],
                        ),
                      ):Container(),
                    );
                  }))
        ],
      ),
    );
  }
}

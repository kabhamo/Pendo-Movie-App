import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import '../description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({Key key, this.tv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          ModifiedText(
            text: 'Popular TV Shows',
            size: 26,
          ),
          SizedBox(height: 25),
          Container(
              height: 210,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      hoverColor: Color(0x2FFFADAD),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                  name: tv[index]['original_name'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      tv[index]['backdrop_path'],
                                  description: tv[index]['overview'],
                                  vote: tv[index]['vote_average']
                                      .toString(),
                                  launch_on: tv[index]
                                  ['first_air_date'],
                                )));
                      },
                      child: tv[index]['original_name'] != null ?
                      Container(
                        width: 280,
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          tv[index]['backdrop_path'], scale: 1.6),
                                ),
                              ),
                              height: 150,
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: ModifiedText(
                                  size: 17,
                                  text: tv[index]['original_name'] != null
                                      ? tv[index]['original_name']
                                      : 'Error'),
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
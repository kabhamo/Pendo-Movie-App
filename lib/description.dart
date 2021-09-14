import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:movie_app_flutter/utils/appbar.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, vote, launch_on;

  const Description(
      {Key key,
      this.name,
      this.description,
      this.bannerurl,
      this.vote,
      this.launch_on})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace:TransparentAppBarPage(name: name,)),
      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ])),
          SizedBox(height: 15),
          Container(  padding: EdgeInsets.all(10),
                  child: ModifiedText(text: '⭐ Average Rating - ' + vote , color:Colors.deepOrange)),
          Container( //todo the title
              padding: EdgeInsets.all(10),
              child: ModifiedText(
                  text: name != null ? name : 'Not Loaded', size: 24)),
          Container( //todo releasing date
              padding: EdgeInsets.only(left: 10),
              child:
              ModifiedText(text: 'Releasing On - ' + launch_on, size: 14)),
          Row(
            children: [
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: ModifiedText(text: description, size: 18)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

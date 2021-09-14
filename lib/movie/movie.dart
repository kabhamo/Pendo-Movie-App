import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

  class Movie {
    final String img1 ;
    final String release_date1 ;
    final String name1;
    final String overview1 ;
    final String vote_average1 ;
    final String id1 ;

       const Movie({
        @required this.img1,
        @required this.release_date1,
        @required this.name1,
        @required this.overview1,
        @required this.id1,
        @required this.vote_average1
    });
  }

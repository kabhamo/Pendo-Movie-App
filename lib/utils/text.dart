import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const ModifiedText({Key key, this.text, this.color, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.roboto(color: color, fontSize: size));
  }
  //another style of text
  Widget playball(BuildContext context) {
    return Text(text, style: GoogleFonts.playball(color: color, fontSize: size));
  }
  Widget lobster(BuildContext context) {
    return Text(text, style: GoogleFonts.lobster(color: color, fontSize: size));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.fontsize,
      this.fontweight,
      this.color,
      this.wspace,
      this.height,
      this.shadow,
      this.align,
      this.maxLines});
  final String text;
  final double? fontsize;
  final FontWeight? fontweight;
  final Color? color;
  final double? wspace;
  final double? height;
  final List<Shadow>? shadow;
  final TextAlign? align;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        fontSize: fontsize,
        fontWeight: fontweight ?? FontWeight.normal,
        color: color ?? Colors.black,
        wordSpacing: wspace ?? 2,
        height: height,
        shadows: shadow,
      )),
      maxLines: maxLines,
    );
  }
}

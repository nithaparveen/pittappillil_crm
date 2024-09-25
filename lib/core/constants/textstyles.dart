import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class GLTextStyles {
  static robotoStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static cabinStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.cabin(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static openSans({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.openSans(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static interStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.inter(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static rubikStyle({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.rubik(
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
    );
  }

  static montserratStyle({double? size, FontWeight? weight, Color? color, double? height, double? letterSpacing}) {
    return GoogleFonts.montserrat(  
      fontSize: size ?? 22,
      fontWeight: weight ?? FontWeight.bold,
      color: color ?? ColorTheme.black,
      height: height,
      letterSpacing: letterSpacing ,
    );
  }
}

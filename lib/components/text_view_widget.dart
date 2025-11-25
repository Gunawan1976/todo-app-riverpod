import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final bool? isBold;
  final int? maxLines;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;
  final TextDecorationStyle? textDecorationStyle;

  TextView({
    Key? key,
    required this.text, this.textColor, this.fontSize, this.textAlign, this.maxLines, this.overflow, this.fontWeight, this.fontStyle, this.textDecoration, this.textDecorationStyle, this.isBold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: textColor ?? Colors.black,fontFamily: isBold == true?'Arimo-Bold':'Arimo',fontSize: fontSize,fontWeight: fontWeight,fontStyle: fontStyle,decoration: textDecoration,decorationStyle: textDecorationStyle,decorationColor: textColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow:overflow,
    );
  }
}
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle style;
  final int? maxLines;
  final TextDirection? textDirection;
  final double? maxFontSize;

  const CustomText(
      {super.key,
      required this.text,
      this.textAlign,
      required this.style,
      this.maxLines,
      this.textDirection,
      this.maxFontSize});

  @override
  Widget build(BuildContext context) {
    return maxFontSize != null
        ? AutoSizeText(
            text,
            maxFontSize: maxFontSize!,
            textAlign: textAlign,
            style: style,
            maxLines: maxLines,
            // overflow: TextOverflow.ellipsis,
            minFontSize: 6,
            // textDirection: textDirection ?? (Languages().isSelLangEnglish() ? TextDirection.ltr:TextDirection.rtl),
          )
        : Text(
            text,
            textAlign: textAlign,
            style: style,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            // textDirection: textDirection ?? (Languages().isSelLangEnglish() ? TextDirection.ltr:TextDirection.rtl),
          );
  }
}
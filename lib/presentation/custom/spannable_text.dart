import 'package:kheticonnect/gen/colors.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpannableTextView extends StatelessWidget {
  final List<SpannableText> spannableTextList;
  final Color color;
  final double fontSize;
  final TextAlign align;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const SpannableTextView({
    super.key,
    required this.spannableTextList,
    this.fontSize = 16.0,
    this.align = TextAlign.center,
    this.color = ColorName.primary,
    this.fontFamily,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpanList = [];

    for (var spannableText in spannableTextList) {
      textSpanList.add(TextSpan(
        style: TextStyle(
          fontFamily: spannableText.fontFamily ?? fontFamily,
          fontWeight: spannableText.fontWeight ?? fontWeight,
          color: spannableText.color ?? color,
          fontSize: spannableText.fontSize ?? fontSize,
          decoration:
              spannableText.isUnderline ? TextDecoration.underline : null,
        ),
        text: spannableText.text,
        recognizer: spannableText.onClick == null
            ? null
            : (TapGestureRecognizer()
              ..onTap = () => spannableText.onClick?.call()),
      ));
    }

    return SizedBox(
      width: 0.8.sw,
      child: RichText(
        textAlign: align,
        text: TextSpan(children: textSpanList),
      ),
    );
  }
}

class SpannableText {
  final String text;
  final bool isUnderline;
  final Color? color;
  final Function()? onClick;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const SpannableText(
      {required this.text,
      this.onClick,
      this.fontSize,
      this.color,
      this.isUnderline = false,
      this.fontFamily,
      this.fontWeight});
}

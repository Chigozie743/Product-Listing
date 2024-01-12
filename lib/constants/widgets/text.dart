import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/color_constant.dart';

class ProductListText extends StatelessWidget {
  final String? text;
  final bool? softWrap;
  final String? fontFamily;
  final double? fontSize;
  final double? letterSpacing;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;

  const ProductListText({
    Key? key,
    required this.text,
    this.softWrap,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.letterSpacing,
    this.fontFamily = 'U8Regular',
    this.textDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      softWrap: softWrap ?? true,
      maxLines: maxLines ?? 10,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize ?? 22.sp,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: textColor ?? blackText,
      ),
    );
  }
}
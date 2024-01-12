import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/constants/widgets/text.dart';

//////////////////////////////////////////////////////////////////////////
/// BUTTON WIDGET
/////////////////////////////////////////////////////////////////////////
class Button extends StatelessWidget {
  const Button({ 
    required this.text, 
    this.width,
    this.radius,
    this.height, 
    this.fontSize, 
    this.textColor, 
    this.textAlign,
    this.borderColor, 
    this.backgroundColor, 
    required this.onClick, super.key});

  final String text;
  final double? width;
  final double? radius;
  final double? height;
  final double? fontSize;
  final Color? textColor;
  final Color? borderColor;
  final Function onClick;
   final TextAlign? textAlign;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        height: height,
        width: width ?? 160.sp,
        decoration: BoxDecoration(
          color: backgroundColor ?? greenBackground,
          border: Border.all(color: borderColor ?? transparentColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.r),
            topRight: Radius.circular(radius ?? 6.r),
            bottomLeft: Radius.circular(radius ?? 6.r),
            bottomRight: Radius.circular(radius ?? 6.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Center(
            child: ProductListText(
              text: text,
              fontSize: fontSize ?? 10.sp,
              textColor: textColor ?? whiteText,
              fontWeight: FontWeight.w500,
              textAlign: textAlign ?? TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

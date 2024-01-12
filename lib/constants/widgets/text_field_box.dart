import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_listing_app/constants/color_constant.dart';
import 'package:product_listing_app/constants/widgets/text.dart';

class TextFieldBox extends StatelessWidget {
  final String? hintText;
  final String? headText;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Widget? suffixColor;
  final Widget? prefixIcon;
  final bool? isCollapsed;
  final bool? readOnly;
  final Function(String)? onChanged;
  final bool? autoFocus;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final Color? textColor;
  final Color? enabledColor;
  final bool? filled;
  final Color? fillColor;
  final int? maxLines;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function()? onIconPressed;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final Color? prefixColor;
  final bool? autoCorrect;
  final bool? enableSuggestion;
  final List<TextInputFormatter>? inputFormatters;
  final double? fontSize;
  final String fontFamily;
  final String autoFillHint;

  const TextFieldBox({
    Key? key,
    this.autoFillHint = '',
    this.hintText,
    this.headText,
    this.height,
    this.width,
    this.onTap,
    this.controller,
    this.validator,
    this.textColor,
    this.textInputAction,
    this.obscureText,
    this.enabledColor,
    this.suffixColor,
    this.prefixIcon,
    this.isCollapsed,
    this.onIconPressed,
    this.readOnly = false,
    this.onChanged,
    this.autoFocus,
    this.suffixIcon,
    this.hintStyle,
    this.filled,
    this.fillColor,
    this.maxLines,
    this.focusNode,
    this.onEditingComplete,
    this.borderColor,
    this.keyboardType,
    this.prefixColor,
    this.autoCorrect,
    this.enableSuggestion,
    this.inputFormatters,
    this.fontSize,
    this.fontFamily = 'U8Regular',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductListText(
          text: headText,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          textColor: blackText,
        ),
        SizedBox(
          height: 3.sp,
        ),

        SizedBox(
          width: width ?? double.infinity,
          height: height,
          child: TextFormField(
            onTap: onTap,
            readOnly: readOnly ?? true,
            autofillHints: [autoFillHint],
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            autocorrect: autoCorrect ?? true,
            enableSuggestions: enableSuggestion ?? true,
            keyboardType: keyboardType,
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            maxLines: maxLines ?? 1,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            style: TextStyle(
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: fontSize ?? 16.sp,
              color: textColor ?? greyTextField,
              decoration: TextDecoration.none,
            ),
            obscureText: obscureText ?? false,
            obscuringCharacter: "*",
            cursorColor: greyTextField,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.sp, vertical: 10.sp),
              suffixIcon: suffixIcon != null ? GestureDetector(
                onTap: onIconPressed,
                child: suffixIcon,
                ) : null,
              prefixIcon: prefixIcon,
              prefixIconColor: prefixColor,
              fillColor: fillColor ?? greyBackground,
              filled: filled ?? true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? transparentColor,
                  width: 2.sp,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: enabledColor ?? transparentColor,
                    width: 0.4.sp),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: enabledColor ?? pinkText,
                    width: 0.4.sp),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
              ),
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: greyTextField,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
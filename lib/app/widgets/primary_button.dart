import 'package:flutter/material.dart';

import '../data/app_text_style.dart';
import '../data/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? color;
  final Color? borderColor;
  final String title;
  final TextStyle? textStyle;
  final Function() onTap;

  const PrimaryButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    required this.title,
    required this.onTap,
    this.textStyle,
    this.borderColor,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 0,
        ),
        height: height ?? 60,
        width: width ?? MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 30),
          color: color ?? AppColors.primaryColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ?? AppTextStyle.textStyle16WhiteW500,
          ),
        ),
      ),
    );
  }
}
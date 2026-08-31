import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panahon_mobprog/constants.dart';
import '../widgets/custom_font.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  late String buttonType, buttonName;
  late Color fontColor, outlineColor;
  late dynamic onPressed;
  CustomButton(
      {super.key,
      this.buttonType = 'elevated',
      required this.buttonName,
      this.fontColor =fbLightPrimary,
      required this.onPressed,
      this.outlineColor = fbTextColorWhite});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    Color effectiveOutline = widget.outlineColor == fbTextColorWhite && !isDark ? Colors.black : widget.outlineColor;
    Color effectiveFont = widget.fontColor == fbLightPrimary && !isDark ? Colors.black : widget.fontColor;

    widget.buttonType = widget.buttonType.toLowerCase();
    if (widget.buttonType == 'outlined') {
      return OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setHeight(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: effectiveOutline),
        ),
        child: CustomFont(
            text: widget.buttonName,
            fontSize: ScreenUtil().setSp(12),
            color: effectiveFont),
      );
    } else if (widget.buttonType == 'text') {
      return TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setHeight(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: CustomFont(
            text: widget.buttonName,
            fontSize: ScreenUtil().setSp(12),
            color: effectiveFont),
      );
    } else {
      return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(30),
            vertical: ScreenUtil().setHeight(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: CustomFont(
            text: widget.buttonName,
            fontSize: ScreenUtil().setSp(12),
            color: effectiveFont),
      ); 
    }
  }
}
import '../widgets/custom_font.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

// ignore: must_be_immutable
class CustomInkwellButton extends StatelessWidget {
  final onTap;
  final double height;
  final double width;
  final double fontSize;
  final String buttonName;
  final Icon icon;
  FontWeight fontWeight;
  Color bgColor;
  Color fontColor;

  CustomInkwellButton(
      {super.key,
      required this.onTap,
      required this.height,
      required this.width,
      this.buttonName = '',
      this.bgColor = fbDarkPrimary,
      this.fontColor = Colors.white,
      this.fontSize = 1,
      this.icon = const Icon(null),
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Card(
      color: bgColor == fbDarkPrimary && isDark ? fbPrimary : bgColor,
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        splashColor: fbSecondary,
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: buttonName == ''
                ? icon
                : CustomFont(
                    text: buttonName, fontSize: fontSize, color: fontColor),
          ),
        ),
      ),
    );
  }
}
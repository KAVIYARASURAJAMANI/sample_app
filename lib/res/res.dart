import 'package:task/res/app_sizes.dart';
import 'package:task/res/assets.dart';
import 'package:task/res/colors.dart';
import 'package:task/res/text_styles.dart';
import 'package:flutter/material.dart';

late Assets assets;
late AppColors colors;
late AppSizes sizes;
late AppTextStyles textStyles;

void initializeResources({required BuildContext context}) {
  sizes = AppSizes()..initializeSize(context);
  colors = AppColors();
  assets = Assets();
  textStyles = AppTextStyles();
}

import 'package:flutter/material.dart';
import 'package:task/res/res.dart';

class CustomLongButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final bool? loading;
  final double? borderRadius;
  final TextStyle? labelStyle;
  const CustomLongButton({
    Key? key,
    this.loading,
    required this.color,
    this.labelStyle,
    this.borderRadius,
    required this.label,
    required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading == true ? () {} : () => onPress(),
      style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10)),
          fixedSize: Size(MediaQuery.of(context).size.width, 50)),
      child: loading == true
          ? Center(child: CircularProgressIndicator(color: colors.kColorWhite))
          : Text(
              label,
              style: labelStyle ?? textStyles.kTextButton,
            ),
    );
  }
}

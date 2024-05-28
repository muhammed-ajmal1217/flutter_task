import 'package:flutter/material.dart';
import 'package:task/constants/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.mainButtonColor,
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      )),
    );
  }
}
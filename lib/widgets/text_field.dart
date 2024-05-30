import 'package:flutter/material.dart';
import 'package:task/constants/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Color? color;
  final int?maxLine;

  TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText,
    this.color,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLine??1,
      obscureText: obscureText??false,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: color??AppColors.loginTextfieldColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

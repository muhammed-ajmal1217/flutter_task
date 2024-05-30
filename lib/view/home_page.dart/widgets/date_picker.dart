import 'package:flutter/material.dart';
import 'package:task/constants/app_colors.dart';

Future<DateTime?> pickDateTime(BuildContext context) async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.floatingActionButtonColor,
          colorScheme: ColorScheme.light(
            primary: AppColors.floatingActionButtonColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.floatingActionButtonColor,
          ),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child!,
      );
    },
  );

  if (date == null) return null;
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.floatingActionButtonColor,
          colorScheme: ColorScheme.light(
            primary: AppColors.floatingActionButtonColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColors.floatingActionButtonColor,
          ),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child!,
      );
    },
  );

  if (time == null) return null;
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

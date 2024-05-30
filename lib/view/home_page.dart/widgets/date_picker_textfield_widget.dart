import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/controller/home_provider.dart';
import 'package:task/widgets/text_field.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.isDateTime,
    required this.onSelect,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isDateTime;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Row(
        children: [
          Expanded(
            child: TextFormFieldWidget(
              hintText: hintText,
              controller: controller,
              color: AppColors.mainTextColor,
            ),
          ),
          IconButton(
            onPressed: () async {
              final dateTime = await onSelect(context);
              if (dateTime == null) return;
              if (isDateTime) {
                value.selectDateTime(dateTime);
                controller.text = DateFormat('yyyy-MM-dd / hh:mm a').format(dateTime);
              } else {
                value.selectEstimatedTime(dateTime);
                controller.text = formatDuration(dateTime);
              }
            },
            icon: Icon(icon),
          ),
        ],
      ),
    );
  }
}

String formatDuration(Duration duration) {
  return '${duration.inHours} hrs ${duration.inMinutes.remainder(60)} mins';
}

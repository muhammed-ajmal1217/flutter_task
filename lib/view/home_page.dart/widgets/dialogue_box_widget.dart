import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/controller/home_provider.dart';
import 'package:task/model/task_model.dart';
import 'package:task/view/home_page.dart/widgets/date_picker.dart';
import 'package:task/view/home_page.dart/widgets/date_picker_textfield_widget.dart';
import 'package:task/widgets/text_field.dart';

class DialogueBoxWidget extends StatefulWidget {
  const DialogueBoxWidget({
    super.key,
    required this.size,
    required this.titleController,
    required this.dateController,
    required this.estimatedTimeController,
    required this.descriptionController,
    required this.value,
    this.task,
    this.isEditing = false,
  });

  final Size size;
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController estimatedTimeController;
  final TextEditingController descriptionController;
  final HomeProvider value;
  final TaskModel? task;
  final bool isEditing;

  @override
  State<DialogueBoxWidget> createState() => _DialogueBoxWidgetState();
}

class _DialogueBoxWidgetState extends State<DialogueBoxWidget> {
  @override
  void initState() {
    Duration duration = Duration(milliseconds: widget.task?.estimatedTime ?? 0);
    String formattedDuration = formatDuration(duration);
    if (widget.isEditing) {
      widget.titleController.text = widget.task!.title ?? '';
      widget.dateController.text =
          DateFormat('yyyy-MM-dd / hh:mm a').format(widget.task!.dateTime!);
      widget.estimatedTimeController.text = formattedDuration;
      widget.descriptionController.text = widget.task!.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditing ? 'Edit Task' : 'Add New Task'),
      content: Container(
        width: widget.size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldWidget(
                  hintText: 'Title',
                  controller: widget.titleController,
                  color: AppColors.mainTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateTextField(
                  controller: widget.dateController,
                  hintText: 'Due date and time',
                  icon: Icons.date_range,
                  isDateTime: true,
                  onSelect: pickDateTime,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DateTextField(
                  controller: widget.estimatedTimeController,
                  hintText: 'Estimated time',
                  icon: Icons.watch,
                  isDateTime: false,
                  onSelect: widget.value.pickDuration,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldWidget(
                  hintText: 'Description',
                  controller: widget.descriptionController,
                  color: AppColors.mainTextColor,
                  maxLine: 3,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.titleController.clear();
            widget.descriptionController.clear();
            widget.dateController.clear();
            widget.estimatedTimeController.clear();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (widget.isEditing) {
              widget.value.updateTask(
                id: widget.task?.id,
                title: widget.titleController.text.trim(),
                description: widget.descriptionController.text.trim(),
                dateTime: widget.value.dateTime,
                estimatedTime: widget.value.estimatedTime,
              );
            } else {
              widget.value.addTask(
                title: widget.titleController.text.trim(),
                description: widget.descriptionController.text.trim(),
                dateTime: widget.value.dateTime,
                estimatedTime: widget.value.estimatedTime,
              );
            }
            Navigator.of(context).pop();
            widget.titleController.clear();
            widget.descriptionController.clear();
            widget.dateController.clear();
            widget.estimatedTimeController.clear();
          },
          child: Text(widget.isEditing ? 'Update' : 'Save'),
        ),
      ],
    );
  }
}

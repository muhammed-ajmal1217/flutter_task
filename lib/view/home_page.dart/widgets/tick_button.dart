import 'package:flutter/material.dart';

class CompletionTicker extends StatelessWidget {
  final bool completed;
  final Function(bool) onPressed;

  const CompletionTicker({
    Key? key,
    required this.completed,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(completed),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: completed
              ? Colors.green.withOpacity(0.3)
              : Colors.orange.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Icon(
                completed ? Icons.check : Icons.hourglass_bottom_outlined,
                color: completed ? Colors.green : Colors.orange,
                size: 15,
              ),
              Text(
                completed ? 'Completed' : 'Incomplete',
                style: TextStyle(
                  color: completed ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

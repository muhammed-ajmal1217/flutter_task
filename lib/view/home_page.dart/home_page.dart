
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/controller/auth_provider.dart';
import 'package:task/controller/home_provider.dart';
import 'package:task/model/task_model.dart';
import 'package:task/utils/notofication_utils.dart';
import 'package:task/view/home_page.dart/widgets/dialogue_box_widget.dart';
import 'package:task/view/home_page.dart/widgets/tick_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
  }
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final estimatedTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: AppColors.loginBackground,
            ),
          ),
          title: Text(
            'Task Manager',
            style: TextStyle(color: AppColors.mainTextColor),
          ),
          actions: [IconButton(
            icon: Icon(Icons.logout_outlined, color: AppColors.mainTextColor),
            onPressed: () {
              Provider.of<AuthProvider>(context,listen: false).signOut();
            },
          ),],
        ),
        
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return StreamBuilder<List<TaskModel>>(
            stream: value.getDatas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print("Snapshot error: ${snapshot.error}");
                return Center(child: Text('Snapshot has Error'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No tasks available'));
              } else {
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final task = data[index];
                    Duration duration = Duration(
                        milliseconds: task.estimatedTime ?? 0);
                    String dateTime = DateFormat('yyyy-MM-dd / hh:mm a')
                        .format(task.dateTime!);
                    String formattedDuration = formatDuration(duration);
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: size.height * 0.22,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(0, 3),
                              color: Colors.grey,
                              spreadRadius: 5,
                              blurStyle: BlurStyle.outer)
                        ], borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    task.title ?? '',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      PopupMenuButton<String>(
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<String>>[
                                          PopupMenuItem<String>(
                                            value: 'Edit',
                                            child: Text('Edit'),
                                          ),
                                          PopupMenuItem<String>(
                                            value: 'Delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
                                        onSelected: (String newValue) {
                                          switch (newValue) {
                                            case 'Edit':
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Consumer<HomeProvider>(
                                                    builder: (context, value, child) {
                                                      return DialogueBoxWidget(
                                                        size: size,
                                                        value: value,
                                                        titleController: titleController,
                                                        descriptionController: descriptionController,
                                                        dateController: dateController,
                                                        estimatedTimeController: estimatedTimeController,
                                                        task: task,
                                                        isEditing: true,
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                              break;
                                            case 'Delete':
                                              value.deleteTask(task.id ?? '');
                                              break;
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      width: size.width * 0.6,
                                      height: size.height * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(255, 242, 242, 242),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(task.description ?? ''),
                                        ),
                                      )),
                                  CompletionTicker(
                                    completed: task.completed,
                                    onPressed: (bool newValue) {
                                      value.toggleCompletedTask(task.id!);
                                      print(task.id);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: size.width * 0.6,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: AppColors.toggleLoginTextColor
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5, right: 5),
                                        child: Center(
                                          child: Text(
                                            '$dateTime',
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: AppColors.dateDisplayColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: AppColors.displayDurationColor
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Text(
                                            '$formattedDuration',
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: AppColors
                                                    .displayDurationColor),
                                          ),
                                        )),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Consumer<HomeProvider>(
                builder: (context, value, child) => DialogueBoxWidget(
                  size: size,
                  value: value,
                  titleController: titleController,
                  dateController: dateController,
                  estimatedTimeController: estimatedTimeController,
                  descriptionController: descriptionController,
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: AppColors.mainTextColor),
        backgroundColor: AppColors.floatingActionButtonColor,
        shape: CircleBorder(),
      ),
    );
  }

  String formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }
}

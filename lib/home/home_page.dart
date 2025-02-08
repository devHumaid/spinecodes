import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskspinecodes/addtask/cubit/task_cubit.dart';
import 'package:taskspinecodes/model/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..fetchTasks(),
      child: Scaffold(
        appBar: AppBar(title: Text("Tasks")),
        body: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            final cubit = context.read<TaskCubit>();
            if (state is TaskLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TaskFailure) {
              return Center(
                  child:
                      Text(state.error, style: TextStyle(color: Colors.red)));
            } else if (state is TaskLoaded) {
              if (state.tasks.isEmpty) {
                return Center(child: Text("No tasks available"));
              }

              return ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  TaskModel task = state.tasks[index];

                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(task.name,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.description),
                          Text("Deadline: ${task.deadline}",
                              style: TextStyle(color: Colors.grey)),
                          Text("Category: ${task.category}",
                              style: TextStyle(color: Colors.grey)),
                          Text("Priority: ${task.priority}",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Status Update Popup Menu
                          PopupMenuButton<String>(
                            onSelected: (newStatus) {
                              cubit.updateTaskStatus(task.id, newStatus);
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: "Pending", child: Text("Pending")),
                              PopupMenuItem(
                                  value: "In Progress",
                                  child: Text("In Progress")),
                              PopupMenuItem(
                                  value: "Completed", child: Text("Completed")),
                            ],
                            child: Chip(
                              label: Text(
                                task.status,
                                style: TextStyle(
                                  color: task.status == 'Completed'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: task.status == 'Completed'
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          // Delete Button
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Delete Task"),
                                    content: Text(
                                        "Are you sure you want to delete this task?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context), // Cancel
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cubit.deleteTask(task.id);
                                          Navigator.pop(
                                              context); // Close the dialog
                                        },
                                        child: Text("Delete",
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No tasks available"));
            }
          },
        ),
      ),
    );
  }

  /// **Confirm Task Deletion**
}

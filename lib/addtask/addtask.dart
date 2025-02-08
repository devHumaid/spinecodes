import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskspinecodes/addtask/cubit/task_cubit.dart';
import 'package:taskspinecodes/model/task_model.dart';
import 'package:taskspinecodes/widgets/custom_textfield.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  String? selectedCategory;
  String? selectedStatus;

  final List<String> categories = ["Work", "Personal", "Shopping", "Health"];
  final List<String> statuses = ["Pending", "In Progress", "Completed"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Add Task")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                final cubit = context.read<TaskCubit>();

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        label: "Task Name",
                        icon: Icons.title,
                      ),
                      CustomTextField(
                        controller: descriptionController,
                        label: "Description",
                        icon: Icons.description,
                        isMultiline: true,
                      ),
                      CustomTextField(
                        controller: deadlineController,
                        label: "Deadline",
                        icon: Icons.calendar_today,
                      ),
                      CustomTextField(
                        controller: priorityController,
                        label: "Priority",
                        icon: Icons.priority_high,
                      ),

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: InputDecoration(
                          labelText: "Category",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedCategory = value;
                        },
                        validator: (value) =>
                            value == null ? "Select a category" : null,
                      ),
                      SizedBox(height: 15),

                      DropdownButtonFormField<String>(
                        value: selectedStatus,
                        decoration: InputDecoration(
                          labelText: "Status",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.task_alt),
                        ),
                        items: statuses.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedStatus = value;
                        },
                        validator: (value) =>
                            value == null ? "Select a status" : null,
                      ),
                      SizedBox(height: 20.h),

                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            TaskModel newTask = TaskModel(
                              id: '',
                              name: nameController.text,
                              description: descriptionController.text,
                              deadline: deadlineController.text,
                              priority: priorityController.text,
                              category: selectedCategory!,
                              status: selectedStatus!,
                              createdAt: Timestamp.now(),
                            );

                            cubit.addTask(newTask);
                          }
                        },
                        child: Text("Add Task"),
                      ),

                      if (state is TaskLoading) CircularProgressIndicator(),

                      if (state is TaskSuccess)
                        Text(state.message,
                            style: TextStyle(color: Colors.green)),

                      if (state is TaskFailure)
                        Text(state.error, style: TextStyle(color: Colors.red)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

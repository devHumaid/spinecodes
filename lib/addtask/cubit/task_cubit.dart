import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:taskspinecodes/model/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTask(TaskModel task) async {
    try {
      emit(TaskLoading());

      DocumentReference docRef = await _firestore.collection('tasks').add(task.toMap());

      await docRef.update({'id': docRef.id});

      emit(TaskSuccess("Task added successfully!"));
    } catch (e) {
      emit(TaskFailure("Failed to add task: $e"));
    }
  }

  Future<void> fetchTasks() async {
    try {
      emit(TaskLoading());

      QuerySnapshot querySnapshot =
          await _firestore.collection('tasks').orderBy('createdAt').get();

      List<TaskModel> tasks = querySnapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskFailure("Failed to fetch tasks: $e"));
    }
  }
  Future<void> updateTaskStatus(String taskId, String newStatus) async {
  try {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
      'status': newStatus,
    });

    fetchTasks(); // Refresh tasks after update
  } catch (e) {
    emit(TaskFailure("Failed to update status: $e"));
  }
}
Future<void> deleteTask(String taskId) async {
  try {
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
    fetchTasks(); // Refresh tasks after deletion
  } catch (e) {
    emit(TaskFailure("Failed to delete task: $e"));
  }
}

}



import 'package:flutter/foundation.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskProvider extends ChangeNotifier {
  bool _getCompletedTasksInProgress = false;

  String? _errorMessage;

  List<TaskModel> _completedTask = [];

  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> get completedTask => _completedTask;

  Future<bool> getCompletedTasks() async {
    bool isSuccess = false;

    _getCompletedTasksInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.completedTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTask = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCompletedTasksInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
import 'package:flutter/foundation.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _getNewTaskListInProgress = false;

  String? _errorMessage;

  List<TaskModel> _NewTaskList = [];

  bool get getNewTaskListInProgress => _getNewTaskListInProgress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> get NewTaskList => _NewTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _getNewTaskListInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.newTaskListUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _NewTaskList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getNewTaskListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
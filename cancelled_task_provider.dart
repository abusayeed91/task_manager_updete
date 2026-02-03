import 'package:flutter/foundation.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskProvider extends ChangeNotifier {
  bool _getCancelledTasksInProgress = false;

  String? _errorMessage;

  List<TaskModel> _cancelledTask = [];

  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> get cancelledTask => _cancelledTask;

  Future<bool> getCancelledTasks() async {
    bool isSuccess = false;

    _getCancelledTasksInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.cancelledTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTask = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCancelledTasksInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
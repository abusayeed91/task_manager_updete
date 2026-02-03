import 'package:flutter/foundation.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ProgressTaskProvider extends ChangeNotifier {
  bool _getProgressTaskInProgress = false;

  String? _errorMessage;

  List<TaskModel> _progressTask = [];

  bool get getProgressTaskInProgress => _getProgressTaskInProgress;

  String? get errorMessage => _errorMessage;

  List<TaskModel> get progressTask => _progressTask;

  Future<bool> getProgressTask() async {
    bool isSuccess = false;

    _getProgressTaskInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.progressTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTask = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getProgressTaskInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
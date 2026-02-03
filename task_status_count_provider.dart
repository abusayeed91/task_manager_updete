import 'package:flutter/cupertino.dart';

import '../../data/models/task_status_count_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class TaskStatusCountProvider extends ChangeNotifier {
  bool inProgress = false;
  List<TaskStatusCountModel> list = [];
  String? error;

  Future<void> getStatusCounts() async {
    inProgress = true;
    notifyListeners();

    final response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );

    inProgress = false;

    if (response.isSuccess) {
      list = (response.responseData['data'] as List)
          .map((e) => TaskStatusCountModel.fromJson(e))
          .toList();
    } else {
      error = response.errorMessage;
    }
    notifyListeners();
  }
}

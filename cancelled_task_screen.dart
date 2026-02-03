import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/centered_progress_indicator.dart';

import '../../data/models/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> _CancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllCancelledTasks();
  }

  Future<void> _getAllCancelledTasks() async {
    _getCancelledTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.cancelledTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _CancelledTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Visibility(
          visible: _getCancelledTaskInProgress == false,
          replacement: CenteredProgressIndicator(),
          child: ListView.separated(
            itemCount: _CancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _CancelledTaskList[index],
                refreshParent: () {
                  _getAllCancelledTasks();
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }
}
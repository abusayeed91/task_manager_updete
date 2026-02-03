import 'package:flutter/material.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';


class ProfileProvider extends ChangeNotifier {
  bool inProgress = false;

  Future<bool> updateProfile(Map<String, dynamic> body) async {
    inProgress = true;
    notifyListeners();

    final response = await ApiCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: body,
    );

    inProgress = false;
    notifyListeners();

    return response.isSuccess;
  }
}

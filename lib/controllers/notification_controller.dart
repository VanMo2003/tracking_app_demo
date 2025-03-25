import 'dart:developer';

import 'package:get/get.dart';
import 'package:tracking_app_demo/data/models/response/notification_res.dart';
import 'package:tracking_app_demo/data/repository/notification_repo.dart';

import '../data/api/api_exception.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  List<NotificationRes>? _notifications;
  List<NotificationRes>? get notifications {
    if (_notifications != null) {
      sortByDateDesc();
    }
    return _notifications;
  }

  void getAllByUser() async {
    Response response = await notificationRepo.getAllByUser();
    if (response.statusCode == 200) {
      _notifications = [];
      for (var element in response.body) {
        var notification = NotificationRes.fromJson(element);
        _notifications!.add(notification);
      }
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
  }

  Future<int> testPush() async {
    Response response = await notificationRepo.testPush();
    if (response.statusCode == 200) {
      getAllByUser();
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();

    return response.statusCode ?? 0;
  }

  void sortByDateDesc() {
    _notifications!.sort(
      (a, b) {
        if (a.date!.compareTo(b.date ?? DateTime.now().millisecondsSinceEpoch) <
            0) {
          return 1;
        }
        return -1;
      },
    );
  }

  void clearData() {
    _notifications = null;
  }
}

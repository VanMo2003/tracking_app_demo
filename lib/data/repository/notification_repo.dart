import '../api/api_client.dart';
import 'package:get/get.dart';
import '/utils/app_constant.dart';

import '../models/body/tracking.dart';

class NotificationRepo {
  final ApiClient apiClient;

  NotificationRepo({required this.apiClient});

  Future<Response> getAllByUser() async {
    return await apiClient.getData(AppConstant.GET_ALL_NOTIFICATION_BY_USER);
  }

  Future<Response> testPush() async {
    return await apiClient.getData(AppConstant.TEST_PUSH);
  }
}

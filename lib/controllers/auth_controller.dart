import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_app_demo/controllers/notification_controller.dart';
import 'package:tracking_app_demo/controllers/user_controller.dart';
import 'package:tracking_app_demo/data/models/response/user_res.dart';
import '../screens/widgets/dialog_widget.dart';
import '/controllers/loading_controller.dart';
import '../data/api/api_exception.dart';
import '../data/repository/auth_repo.dart';
import '../data/models/response/token_res.dart';
import '/utils/language/key_language.dart';
import '../helper/route_helper.dart';
import 'image_controller.dart';
import 'post_controller.dart';
import 'search_controller.dart';
import 'tracking_controller.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  Future<int> login(String username, String password) async {
    Response response = await authRepo.login(username, password);

    if (response.statusCode == 200) {
      TokenResponse tokenResponse = TokenResponse.fromJson(response.body);
      authRepo.saveUserToken(tokenResponse.accessToken!);
    } else {
      ApiException.checkException(response.statusCode);
    }

    Get.find<LoadingController>().noLoading();
    update();
    return response.statusCode ?? 0;
  }

  void logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return dialogQuestionWidget(
          context,
          KeyLanguage.logout.tr,
          KeyLanguage.logoutQuestion.tr,
          () async {

            UserRes userRes = Get.find<UserController>().user!.copyWith(
                tokenDevice: null
            );
            Get.find<UserController>().updateMyself(userRes);

            Get.find<LoadingController>().loading(handle: () async{
              Response response = await authRepo.logout();
              if (response.statusCode == 200) {
                authRepo.removeUserToken();
                clearData();
                Get.offNamed(RouteHelper.getSignInRoute());
              } else {
                ApiException.checkException(response.statusCode);
              }
              update();

            },);
          },
        );
      },
    );
  }

  void clearData() {
    Get.find<UserController>().clearData();
    Get.find<TrackingController>().clearData();
    Get.find<SearchByPageController>().clearData();
    Get.find<PostController>().clearData();
    Get.find<ImageController>().clearData();
    Get.find<NotificationController>().clearData();
  }
}

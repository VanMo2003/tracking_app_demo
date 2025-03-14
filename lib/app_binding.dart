import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app_demo/controllers/notification_controller.dart';
import 'package:tracking_app_demo/data/repository/notification_repo.dart';
import '/controllers/auth_controller.dart';
import '/controllers/langue_controller.dart';
import '/controllers/loading_controller.dart';
import '/controllers/post_controller.dart';
import '/controllers/search_controller.dart';
import '/controllers/tracking_controller.dart';
import '/controllers/image_controller.dart';
import 'controllers/user_controller.dart';
import 'data/api/api_client.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/post_repo.dart';
import 'data/repository/search_repo.dart';
import 'data/repository/tracking_repo.dart';
import 'data/repository/upload_file_repo.dart';
import '/services/language_service.dart';
import 'data/repository/user_repo.dart';
import 'theme/theme_controller.dart';
import '/utils/app_constant.dart';

Future<void> binding() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LanguageService());
  Get.lazyPut(() =>
      ApiClient(urlBase: AppConstant.BASE_URL, sharedPreferences: Get.find()));

  // repository
  Get.lazyPut(() =>
      UploadFileRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
          () => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => TrackingRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));

  Get.lazyPut(() => PostRepo(apiClient: Get.find()));

  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));

  // controller
  Get.lazyPut(() => ImageController(uploadFileRepo: Get.find()));

  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  Get.lazyPut(() => LoadingController());

  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  Get.lazyPut(() => UserController(authRepo: Get.find()));

  Get.lazyPut(() => TrackingController(trackingRepo: Get.find()));

  Get.lazyPut(() => SearchByPageController(searchRepo: Get.find()));

  Get.lazyPut(() => PostController(postRepo: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
}

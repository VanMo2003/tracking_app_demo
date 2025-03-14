import 'package:get/get.dart';
import 'package:tracking_app_demo/controllers/search_controller.dart';

import '../data/api/api_exception.dart';
import '../data/models/response/user_res.dart';
import '../data/repository/user_repo.dart';
import '../helper/date_converter_hepler.dart';
import '../utils/language/key_language.dart';
import '../views/custom_snackbar.dart';
import 'post_controller.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo authRepo;

  UserController({required this.authRepo}) : _user = UserRes();
  UserRes? _user;
  bool _isAdmin = false;

  UserRes? get user => _user;
  bool get isAdmin => _isAdmin;

  Future<int> registor(UserRes user) async {
    Response response = await authRepo.registor(user);

    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
    } else {
      ApiException.checkException(response.statusCode, isRegistor: true);
    }
    update();
    return response.statusCode!;
  }

  Future<int> getCurrentUser() async {
    Response response = await authRepo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
        if (_user!.roles != null) {
          if(_user!.roles!.isEmpty){
            _isAdmin = true;
          }else {
            for (var element in _user!.roles!) {
              if (element.id == 3) {
                _isAdmin = true;
              }
            }
          }
        }

    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  Future<int> updateMyself(UserRes userNew) async {
    Response response = await authRepo.updateMyself(userNew);
    if (response.statusCode == 200) {
      _user = UserRes.fromJson(response.body);
      Get.find<PostController>().clearData();
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  void updateInfoUser(UserRes userNew) async {
    Response response = await authRepo.updateUserById(userNew);
    if (response.statusCode == 200) {
      if (Get.find<SearchByPageController>().listResult != null) {
        for (var element in Get.find<SearchByPageController>().listResult!) {
          if (element.id == userNew.id) {
            int index =
            Get.find<SearchByPageController>().listResult!.indexOf(element);
            Get.find<SearchByPageController>()
              ..listResult![index] = userNew
              ..update();
            showCustomSnackBar(KeyLanguage.updateSuccess.tr, isError: false);
          }
        }
      }
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
  }

  Future<void> checkIn() async {
    Response response = await authRepo.checkIn(_user!.id.toString());
    if (response.statusCode == 200) {
      showCustomSnackBar(
        "${KeyLanguage.attendanceSuccess.tr} : ${DateConverter.formatDate(DateTime.now())}",
        isError: false,
      );
    } else {
      ApiException.checkException(response.statusCode,
          err: KeyLanguage.attendanced.tr);
    }
    update();
  }

  Future<int> lock(int id) async {
    Response response = await authRepo.lock(id);
    if (response.statusCode == 200) {
      Get.find<SearchByPageController>()
        ..listResult!.where((element) => element.id == id).first.active = false
        ..update();
    } else {
      ApiException.checkException(response.statusCode);
    }
    update();
    return response.statusCode!;
  }

  void clearData() {
    _user = null;
    _isAdmin = false;
  }
}

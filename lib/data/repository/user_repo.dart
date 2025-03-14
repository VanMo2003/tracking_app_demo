import 'package:shared_preferences/shared_preferences.dart';
import '../models/response/user_res.dart';
import '../api/api_client.dart';
import '/utils/app_constant.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registor(UserRes user) async {
    return await apiClient.postData(AppConstant.REGISTOR_URI, user.toJson());
  }

  Future<Response> getCurrentUser() async {
    return await apiClient.getData(AppConstant.GET_USER);
  }

  Future<Response> updateMyself(UserRes user) async {
    return await apiClient.postData(AppConstant.UPDATE_MYSELF, user);
  }

  Future<Response> updateUserById(UserRes user) async {
    return await apiClient.postData(
      "${AppConstant.UPDATE_USER}/${user.id}",
      user,
    );
  }

  Future<Response> lock(int id) async {
    return await apiClient.getData("${AppConstant.LOCK}/$id");
  }

  Future<Response> checkIn(String ip) async {
    return await apiClient.getData(
      AppConstant.CHECK_IN,
      query: {"ip": ip},
    );
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = "Bearer $token";
    apiClient.updateHeader("Bearer $token", null,
        sharedPreferences.getString(AppConstant.LANGUAGE_CODE) ?? "vi", 0);
    return await sharedPreferences.setString(
        AppConstant.TOKEN, "Bearer $token");
  }

  Future<bool> removeUserToken() async {
    return await sharedPreferences.remove(AppConstant.TOKEN);
  }

  Future<String?> getUserToken() async {
    return sharedPreferences.getString(AppConstant.TOKEN);
  }
}

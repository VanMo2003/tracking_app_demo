import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tracking_app_demo/controllers/user_controller.dart';
import 'package:tracking_app_demo/data/models/response/user_res.dart';
import '../data/api/api_exception.dart';
import '../data/models/response/image_res.dart';
import '../data/repository/upload_file_repo.dart';
import '../data/models/body/multipart.dart';
import 'loading_controller.dart';

class ImageController extends GetxController implements GetxService {
  UploadFileRepo uploadFileRepo;

  ImageController({required this.uploadFileRepo});

  Uint8List? _image;

  Uint8List? get image => _image;

  Future<int> uploadImage(MultipartBody multipartBody, String filename, {bool isAvatar = false}) async {
    Response response =
        await uploadFileRepo.uploadFile(multipartBody, filename: filename);

    if (response.statusCode == 200) {
      ImageRes imageRes = ImageRes.fromJson(response.body);

      if(isAvatar) {
        UserRes userNew = Get.find<UserController>().user!.copyWith(
          image: imageRes.name
        );
        await Get.find<UserController>().updateMyself(userNew);
      }

      Get.find<LoadingController>().noLoading();
    } else {
      ApiException.checkException(response.statusCode);
    }

    return response.statusCode ?? 0;

  }

  Future<int> getImageByName(String filename) async {
    Response response = await uploadFileRepo.getFileByName(filename);

    if (response.statusCode == 200) {
      _image = Uint8List.fromList(response.body.codeUnits);
      update();

    } else {
      ApiException.checkException(response.statusCode);
    }

    return response.statusCode ?? 0;
  }

  changeImage(Uint8List image) {
    _image = image;
    update();
  }

  clearData() {
    _image = null;
    update();
  }
}

import 'package:get/get.dart';

import '../utils/dimensions.dart';

class LoadingController extends GetxController implements GetxService {
  LoadingController({this.isLoading = false});

  bool isLoading;

  Future<void> loading({required Function() handle}) async {
    isLoading = true;
    update();
    await Future.delayed(
      const Duration(milliseconds: Dimensions.TIME_LOADING), () {
        handle();
        noLoading();
      },
    );
  }

  void noLoading() {
    isLoading = false;
    update();
  }
}

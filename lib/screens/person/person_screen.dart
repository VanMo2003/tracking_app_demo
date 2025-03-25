import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/keep/v1.dart';
import 'package:tracking_app_demo/controllers/loading_controller.dart';
import 'package:tracking_app_demo/data/models/response/user_res.dart';
import '../../controllers/user_controller.dart';
import '/controllers/auth_controller.dart';
import '../../theme/theme_controller.dart';
import '/utils/language/key_language.dart';
import '/utils/styles.dart';
import '../info_user/info_user_screen.dart';

import '../../helper/loading_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../widgets/dropdown_language_widget.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<UserController>(builder: (controller) {
        UserRes user = controller.user ?? UserRes();
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          ),
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: Dimensions.RADIUS_SIZE_OVER_LARGE,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: user.image != null
                        ? Image.asset(user.image!)
                        : Icon(
                            Icons.person,
                            size: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                            color: Theme.of(context).cardColor,
                          ),
                  ),
                  const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
                  Text(
                    user.displayName ?? KeyLanguage.displayName.tr,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                        color: Theme.of(context).disabledColor),
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
                  button(
                    KeyLanguage.infoPerson.tr,
                    const Icon(Icons.person),
                    () {
                      Get.to(const InfoUserScreen());
                    },
                  ),
                  const SizedBox(height: Dimensions.SIZE_BOX_HEIGHT_DEFAULT),
                  button(
                    "${KeyLanguage.light.tr}/${KeyLanguage.dark.tr}",
                    Icon(
                      Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: ColorResources.getBlackColor(),
                    ),
                    () {
                      changeTheme();
                    },
                  ),
                  const Spacer(),
                  button(
                    KeyLanguage.logout.tr,
                    const Icon(Icons.logout),
                    () {
                      Get.find<AuthController>().logout(context);
                    },
                  ),
                ],
              ),
              const Positioned(
                right: 0,
                child: DropdownLangueWidget(),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget button(String label, Widget icon, void Function() onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Theme.of(context).cardColor),
        foregroundColor: WidgetStateProperty.all(
          Theme.of(context).disabledColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: robotoBlack.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: Theme.of(context).disabledColor),
            ),
            icon,
          ],
        ),
      ),
    );
  }

  void changeTheme() async {
    Get.find<LoadingController>().loading(handle: () {
      Get.find<ThemeController>().toggleTheme();
    },);
  }
}

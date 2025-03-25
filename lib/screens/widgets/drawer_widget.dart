import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracking_app_demo/controllers/loading_controller.dart';
import 'package:tracking_app_demo/data/models/body/multipart.dart';
import 'package:tracking_app_demo/data/models/response/user_res.dart';
import '../../controllers/user_controller.dart';
import '../../utils/app_constant.dart';
import '/controllers/image_controller.dart';
import '/helper/route_helper.dart';
import '/utils/language/key_language.dart';
import 'button_drawer_widget.dart';
import 'dropdown_language_widget.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

import '../../theme/theme_controller.dart';
import '../../helper/loading_helper.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/asset_util.dart';
import '../../utils/styles.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  TextEditingController contentPostController = TextEditingController();
  RxBool isOpenMenuPost = false.obs;
  File? selectedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var safe = MediaQuery.of(context).padding.top;

    return GetBuilder<UserController>(
      builder: (userController) {
        UserRes user = userController.user!;
        return Container(
          height: size.height,
          width: size.width * 0.8,
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: safe,
                    left: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetUtil.backgroundDrawer),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: size.height * 0.3,
                  width: size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint("pick image avatar");
                          _pickImageFromGallery();
                        },
                        child: CircleAvatar(
                          radius: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE,
                          backgroundColor: Theme.of(context).cardColor,
                          backgroundImage: user.image != null
                              ? NetworkImage(
                                  AppConstant.URL_GET_IMAGE + user.image!)
                              : AssetImage(AssetUtil.avatar),
                        ),
                      ),
                      const SizedBox(
                          height: Dimensions.PADDING_SIZE_OVER_LARGE),
                      RichText(
                        text: TextSpan(
                          style: robotoBold.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                          ),
                          children: [
                            TextSpan(
                              text: user.username ?? KeyLanguage.username.tr,
                            ),
                            TextSpan(
                              text:
                                  " (${user.displayName ?? KeyLanguage.displayName.tr})",
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                color:
                                    Theme.of(context).cardColor.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        user.email ?? KeyLanguage.displayName.tr,
                        style: robotoBlack.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: Theme.of(context).cardColor.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.3,
                left: 0,
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      ButtonDrawerWidget(
                        label: KeyLanguage.infoPerson.tr,
                        onTap: () {
                          Get.toNamed(RouteHelper.getInfoUserRoute());
                        },
                        icon: Image.asset(
                          AssetUtil.person,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        onTap: () {
                          Get.toNamed(RouteHelper.getPostRoute());
                        },
                        label: KeyLanguage.posts.tr,
                        icon: Icon(
                          Icons.list,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.getPostRoute(
                              userId: user.id!.toString(),
                              displayName: user.displayName.toString(),
                            ),
                          );
                        },
                        label: KeyLanguage.post.tr,
                        icon: Icon(
                          Icons.person_search_outlined,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.getNotificationRoute(),
                          );
                        },
                        label: KeyLanguage.notification.tr,
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        onTap: () async {
                          Get.find<LoadingController>().loading(handle: () {
                            Get.find<UserController>().checkIn();
                            closeDrawer();
                          });
                        },
                        label: KeyLanguage.attendance.tr,
                        icon: Image.asset(
                          AssetUtil.attendance,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      ButtonDrawerWidget(
                        label: Get.find<ThemeController>().darkTheme
                            ? KeyLanguage.dark.tr
                            : KeyLanguage.light.tr,
                        onTap: () async {
                          Get.find<LoadingController>().loading(handle: () {
                            Get.find<ThemeController>().toggleTheme();
                          });
                        },
                        icon: Icon(
                          Get.find<ThemeController>().darkTheme
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      const Spacer(),
                      ButtonDrawerWidget(
                        label: KeyLanguage.logout.tr,
                        onTap: () {
                          Get.find<AuthController>().logout(context);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: safe + 5,
                right: 25,
                child: const DropdownLangueWidget(),
              )
            ],
          ),
        );
      },
    );
  }

  void closeDrawer() {
    widget.scaffoldKey.currentState?.closeDrawer();
  }

  Future _pickImageFromGallery() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (resultImage == null) return;

    selectedFile = File(resultImage.path);

    MultipartBody multipartBody = MultipartBody(file: selectedFile);
    String fileName = "${DateTime.now()}.png";
    Get.find<LoadingController>().loading(
      handle: () {
        Get.find<ImageController>()
            .uploadImage(multipartBody, fileName, isAvatar: true);
      },
    );
  }
}

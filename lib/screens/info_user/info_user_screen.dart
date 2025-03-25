import 'package:flutter/material.dart';
import 'package:tracking_app_demo/controllers/user_controller.dart';
import 'package:tracking_app_demo/views/custom_snackbar.dart';
import '/controllers/auth_controller.dart';
import '../../data/models/response/user_res.dart';
import '/utils/color_resources.dart';
import '/utils/language/key_language.dart';
import '/utils/styles.dart';
import '../widgets/dialog_widget.dart';
import 'package:get/get.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  final TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyLanguage.infoPerson.tr),
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(
        builder: (controller) {
          UserRes user = controller.user ?? UserRes();
          return Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                showInfo(
                    context, KeyLanguage.email.tr,
                    user.email ?? "example@gmail.com",
                    editingController,
                    user),
                showInfo(
                    context,
                    KeyLanguage.displayName.tr,
                    user.displayName ?? KeyLanguage.displayName.tr,
                    editingController,
                    user),
                showInfo(
                    context,
                    KeyLanguage.university.tr,
                    user.university ?? KeyLanguage.university.tr,
                    editingController,
                    user),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showInfo(BuildContext context, String label, String content,
      TextEditingController controller, UserRes user) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          style: robotoMedium.copyWith(
              fontSize: 16, color: ColorResources.getBlackColor()),
          children: <TextSpan>[
            TextSpan(
              text: "$label : ",
              style: robotoBlack.copyWith(
                  fontSize: 18, color: ColorResources.getBlackColor()),
            ),
            TextSpan(text: content),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          controller.text = content;

          showDialog(
            context: context,
            builder: (context) {
              return dialogAddWidget(
                hintText: label,
                textButton: KeyLanguage.save.tr,
                context: context,
                controller: controller,
                onAdd: () {
                  if (label == KeyLanguage.email.tr) {
                    user.email = controller.text;
                  } else if (label == KeyLanguage.displayName.tr) {
                    user.displayName = controller.text;
                  } else if (label == KeyLanguage.university.tr) {
                    user.university = controller.text;
                  }

                  Get.find<UserController>().updateMyself(user).then(
                    (value) {
                      if (value == 200) {
                        showCustomSnackBar(KeyLanguage.updateSuccess.tr);
                      }
                    },
                  );
                },
              );
            },
          );
        },
        icon: const Icon(Icons.save_as_outlined),
      ),
    );
  }
}

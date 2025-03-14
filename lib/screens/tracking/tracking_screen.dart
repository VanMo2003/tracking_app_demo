import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/user_controller.dart';
import '../../../views/custom_snackbar.dart';
import '../../controllers/loading_controller.dart';
import '../widgets/dialog_widget.dart';
import '/controllers/tracking_controller.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';

import '../../../helper/loading_helper.dart';
import '../../../data/models/body/tracking.dart';

import 'widgets/tracking_item.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  TextEditingController contentController = TextEditingController();

  var showOptions = false.obs;

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<TrackingController>(
          builder: (controller) {
            if (controller.list == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Tracking> list = controller.list!;

            if (list.isEmpty) {
              return Center(
                child: Text(KeyLanguage.listEmpty.tr),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: ListView.builder(
                itemCount: list.length + 1,
                itemBuilder: (context, index) {
                  if(index == list.length){
                    return Container(height: Get.height * 0.06,);
                  }
                  var tracking = list[index];
                  return TrackingItem(
                    tracking: tracking,
                  );
                },
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: Container(
            height: Get.height * 0.06,
            width: Get.height * 0.06,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    contentController.clear();
                    return dialogAddWidget(
                      textButton: KeyLanguage.add.tr,
                      context: context,
                      controller: contentController,
                      onAdd: () {
                        addTracking();
                      },
                    );
                  },
                );
              },
              tooltip: KeyLanguage.add.tr,
              child: Icon(
                Icons.add,
                color: Theme.of(context).canvasColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  void addTracking() async {
    Get.find<LoadingController>().loading(handle: ()
    {
      var userCurrent = Get
          .find<UserController>()
          .user;
      Tracking tracking = Tracking(
        content: contentController.text,
        date: DateTime
            .now()
            .millisecondsSinceEpoch,
        user: userCurrent,
      );

      Get.find<TrackingController>().addTracking(tracking).then(
            (value) {
          if (value == 200) {
            showCustomSnackBar(
                "${KeyLanguage.addSuccess.tr} : ${tracking.content}",
                isError: false);
          }
        },
      );
      contentController.clear();
    });
  }
}

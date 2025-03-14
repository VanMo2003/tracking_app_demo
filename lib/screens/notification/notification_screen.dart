import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_app_demo/controllers/notification_controller.dart';
import 'package:tracking_app_demo/data/models/response/notification_res.dart';
import 'package:tracking_app_demo/helper/notification_helper.dart';
import 'package:tracking_app_demo/screens/notification/widgets/notification_item.dart';

import '../../utils/dimensions.dart';
import '../../utils/language/key_language.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
    debugPrint("init");
    if(Get.find<NotificationController>().notifications == null){
      Get.find<NotificationController>().getAllByUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyLanguage.notification.tr),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GetBuilder<NotificationController>(
            builder: (controller) {
              if (controller.notifications == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<NotificationRes> notifications = controller.notifications!;

              if (notifications.isEmpty) {
                return Center(
                  child: Text(KeyLanguage.listEmpty.tr),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: ListView.builder(
                  itemCount: notifications.length + 1,
                  itemBuilder: (context, index) {
                    if(index == notifications.length){
                      return Container(height: Get.height * 0.06 + Dimensions.PADDING_SIZE_DEFAULT,);
                    }
                    var notification = notifications[index];
                    return NotificationItem(notificationRes: notification);
                  },
                ),
              );
            },
          ),
          Positioned(
            bottom: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_SMALL,
            child: SizedBox(
              height: Get.height * 0.06,
              width: Get.height * 0.06,
              child: FloatingActionButton(
                onPressed: () {
                  NotificationHelper.sendMessage().then((value) {
                    if(value == 200)
                      debugPrint("FCM message send successfully");
                    else
                      debugPrint("Failed to send FCM message ${value}");
                  },);
                },
                tooltip: KeyLanguage.notification.tr,
                child: Icon(
                  Icons.notifications,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

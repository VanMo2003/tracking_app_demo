import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking_app_demo/data/models/response/notification_res.dart';
import 'package:tracking_app_demo/helper/date_converter_hepler.dart';
import 'package:tracking_app_demo/utils/language/key_language.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notificationRes});

  final NotificationRes notificationRes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      margin: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_SMALL,
          horizontal: Dimensions.MARGIN_SIZE_SMALL),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
          border: Border.all(
            color: Theme.of(context).disabledColor.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2.0, 2.0),
              color: Theme.of(context).disabledColor.withOpacity(0.3),
              blurRadius: 3,
            ),
          ]),
      child: Stack(
        children: [
          SizedBox(
            width: Get.width - 32.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationRes.title ?? KeyLanguage.title.tr,
                  style: robotoBlack.copyWith(
                      fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                ),
                Text(
                  notificationRes.body ?? KeyLanguage.title.tr,
                  overflow: TextOverflow.ellipsis,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
                Text(
                 DateConverter.convertTimeStampToString(notificationRes.date ?? DateTime.now().microsecondsSinceEpoch),
                  style: robotoRegular.copyWith(
                      color: Colors.grey,
                      fontSize: Dimensions.FONT_SIZE_LARGE
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

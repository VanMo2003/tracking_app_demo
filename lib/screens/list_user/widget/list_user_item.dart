import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tracking_app_demo/utils/app_constant.dart';
import 'package:tracking_app_demo/utils/asset_util.dart';
import '../../../data/models/response/user_res.dart';
import 'package:get/get.dart';
import '/utils/dimensions.dart';
import '../detail_user_screen.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/styles.dart';

enum SampleItem { update, lock, unlock }

class ListUserItem extends StatefulWidget {
  const ListUserItem({super.key, required this.user});

  final UserRes user;

  @override
  State<ListUserItem> createState() => _ListUserItemState();
}

class _ListUserItemState extends State<ListUserItem> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Opacity(
      opacity: widget.user.active ?? false ? 1 : 0.5,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          border: Border.all(
            color: Theme.of(context).disabledColor.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2.0, 2.0),
              color: Theme.of(context).disabledColor.withOpacity(0.3),
              blurRadius: 3,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        height: size.height * 0.1,
        width: double.infinity,
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              debugPrint('click avatar');
            },
            child: CircleAvatar(
              radius: Dimensions.RADIUS_SIZE_LARGE,
              backgroundImage: widget.user.image != null && widget.user.image != ""
                  ? NetworkImage(AppConstant.URL_GET_IMAGE + (widget.user.image!))
                  : const AssetImage(AssetUtil.avatar),
            ),
          ),
          onTap: () {
            Get.to(DetailUserScreen(user: widget.user));
          },
          title: Text(
            widget.user.displayName ?? KeyLanguage.displayName.tr,
            style:
                robotoBlack.copyWith(fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            widget.user.email ?? KeyLanguage.email.tr,
            style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: widget.user.active ?? false
              ? null
              : Icon(
                  Icons.lock,
                  color: ColorResources.getRedColor(),
                ),
        ),
      ),
    );
  }
}

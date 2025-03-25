import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app_demo/utils/app_constant.dart';
import '/helper/date_converter_hepler.dart';
import '../../../data/models/body/posts/content.dart';
import '/utils/asset_util.dart';
import '/utils/color_resources.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import '/utils/styles.dart';
import 'package:get/get.dart';
import '../post_comment.dart';
import 'button_animated.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.content,
    this.isClick = true,
  });

  final Content content;
  final bool isClick;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      // height: size.height * 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: Dimensions.RADIUS_EXTRA_LARGE_OVER,
                backgroundImage: widget.content.user?.image != null && widget.content.user?.image != ""
                    ? NetworkImage(AppConstant.URL_GET_IMAGE + widget.content.user!.image!)
                    : const AssetImage(AssetUtil.avatar),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.content.user?.displayName ?? KeyLanguage.displayName.tr,
                      style: robotoBold.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    Text(
                      widget.content.date != null
                          ? DateConverter.convertTimeStampToString(
                              widget.content.date!)
                          : DateConverter.formatDate(DateTime.now()),
                      style: robotoBlack.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).disabledColor,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            child: Text(
              widget.content.content ?? KeyLanguage.content.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                color: Theme.of(context).disabledColor,
              ),
            ),
          ),
          if ((widget.content.id ?? 0) % 2 != 0) ...[
            Container(
              height: 300,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor,
                image: DecorationImage(
                  image: widget.content.media == null
                      ? const AssetImage(AssetUtil.backgroundPost)
                      : NetworkImage(AppConstant.URL_GET_IMAGE + widget.content.media!.filePath!),
                  fit: BoxFit.cover,
                ),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              margin: const EdgeInsets.only(top: 8),
            ),
          ],
          Row(
            children: [
              ButtonAnimated(
                listenable: animation,
                controller: controller,
                animation: animation,
                content: widget.content,
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (widget.isClick) {
                    if (kDebugMode) {
                      debugPrint('click comments post ${widget.content.id}');
                    }
                    Get.to(() => PostCommentWidget(content: widget.content));
                  }
                },
                icon: Icon(
                  Icons.message_outlined,
                  color: ColorResources.getBlackColor(),
                ),
                label: Text(
                  "${KeyLanguage.comment.tr} (${widget.content.comments?.length ?? 0})",
                  style: robotoBold.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

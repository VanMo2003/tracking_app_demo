import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/styles.dart';
import '/controllers/post_controller.dart';
import '/helper/route_helper.dart';
import '../../../data/models/body/posts/content.dart';
import '/utils/dimensions.dart';
import '/utils/language/key_language.dart';
import 'package:get/get.dart';
import 'widget/post_item.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool isAll = true;
  String? id = Get.parameters["userId"];
  String? displayName = Get.parameters["displayName"];

  @override
  void initState() {
    super.initState();
    isAll = id == "";

    if(isAll){
      if(Get.find<PostController>().posts == null){
        debugPrint("load post");
        Get.find<PostController>().getPosts();
      }
    }else{
      if(Get.find<PostController>().postsByUser == null){
        Get.find<PostController>().getPostsByUser();
      }
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent && scrollController.position.pixels > Get.height*0.6) {
        if (!Get.find<PostController>().last && id == "") {
          Get.find<PostController>().getPosts();
        } else if (!Get.find<PostController>().lastByUser && id != "") {
          Get.find<PostController>().getPostsByUser();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          displayName == ""
              ? KeyLanguage.posts.tr
              : "Bài viết của $displayName",
          style: robotoBold.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            highlightColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            child: Icon(
              Icons.house_outlined,
              size: 32,
              color: Theme.of(context).canvasColor,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor.withOpacity(0.8),
      body: GetBuilder<PostController>(
        builder: (controller) {
          if(isAll){
            if (controller.contents == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            if (controller.contents!.isEmpty) {
              return Center(
                child: Text(KeyLanguage.listEmpty.tr),
              );
            }
          }else{
            if (controller.contentsByUser == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            if (controller.contentsByUser!.isEmpty) {
              return Center(
                child: Text(KeyLanguage.listEmpty.tr),
              );
            }
          }

          List<Content> contents = isAll ? controller.contents! : controller.contentsByUser!;
          int length = 0;
          if (id == "") {
            length = controller.last ? contents.length : contents.length + 1;
          } else {
            length =
                controller.lastByUser ? contents.length : contents.length + 1;
          }
          return SizedBox(
            height: Get.height,
            child: ListView.builder(
              controller: scrollController,
              itemCount: length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (id == "") {
                  if (index == contents.length && !controller.last) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                } else {
                  if (index == contents.length && !controller.lastByUser) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }

                return PostItem(
                  content: contents[index],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: id == ""
          ? null
          : FloatingActionButton(
              onPressed: () {
                Get.toNamed(RouteHelper.addPost);
              },
              child: Icon(
                Icons.post_add,
                color: Theme.of(context).canvasColor,
              ),
            ),
    );
  }
}

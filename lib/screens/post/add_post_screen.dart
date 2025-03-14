import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracking_app_demo/controllers/user_controller.dart';
import '../../controllers/loading_controller.dart';
import '../../data/models/body/multipart.dart';
import '../widgets/text_field_widget.dart';
import '/utils/language/key_language.dart';
import 'widget/button_add_post_widget.dart';
import '../../../views/custom_loading.dart';
import '../../../controllers/post_controller.dart';
import '../../../controllers/image_controller.dart';
import '../../../data/models/body/posts/content.dart';
import '../../../utils/dimensions.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController contentController = TextEditingController();
  File? selectedFile;
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    Get.find<ImageController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(KeyLanguage.addPost.tr),
          centerTitle: true,
        ),
        body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldWidget(
                    autoFocus: true,
                    controller: contentController,
                    hintText: KeyLanguage.postContent.tr,
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  GetBuilder<ImageController>(
                    builder: (controller) {
                      if (controller.image == null) {
                        return GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.image,
                                size: 32,
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Text(KeyLanguage.pickImage.tr)
                            ],
                          ),
                        );
                      }
                      return GestureDetector(
                          onTap: () {
                            _pickImageFromGallery();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(controller.image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ButtonAddPostWidget(
                        label: KeyLanguage.addPost.tr,
                        onPressed: () {
                          addPost();
                        },
                      ),
                      const SizedBox(
                        width: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      ButtonAddPostWidget(
                        label: KeyLanguage.cancel.tr,
                        onPressed: () {
                          if (Get.find<ImageController>().image != null) {
                            Get.find<ImageController>().clearData();
                          }
                          contentController.clear();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addPost() async {
    if (key.currentState!.validate()) {


      Get.find<LoadingController>().loading(handle: () {
        late Content content;

        content = Content(
          id: 0,
          date: DateTime.now().millisecondsSinceEpoch,
          content: contentController.text,
          user: Get.find<UserController>().user,
        );

        Get.find<PostController>().addContent(content);
        Get.find<ImageController>().clearData();
        contentController.clear();
        Get.back();
      },);
    }
  }

  Future _pickImageFromGallery() async {
    final resultImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (resultImage == null) return;


    selectedFile = File(resultImage.path);

    MultipartBody multipartBody = MultipartBody(
        file: selectedFile
    );
    String fileName = "post_${DateTime.now()}.png";

    Get.find<LoadingController>().loading(handle: () {
      Get.find<ImageController>().uploadImage(multipartBody, fileName);
      Get.find<ImageController>().changeImage(File(resultImage.path).readAsBytesSync());
    },);
  }
}

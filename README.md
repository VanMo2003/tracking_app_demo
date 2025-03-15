├── lib
    ├── app_binding.dart
    ├── controllers
    │   ├── auth_controller.dart
    │   ├── image_controller.dart
    │   ├── langue_controller.dart
    │   ├── loading_controller.dart
    │   ├── notification_controller.dart
    │   ├── post_controller.dart
    │   ├── search_controller.dart
    │   ├── tracking_controller.dart
    │   └── user_controller.dart
    ├── data
    │   ├── api
    │   │   ├── api_client.dart
    │   │   └── api_exception.dart
    │   ├── models
    │   │   ├── body
    │   │   │   ├── multipart.dart
    │   │   │   ├── posts
    │   │   │   │   ├── comment.dart
    │   │   │   │   ├── content.dart
    │   │   │   │   ├── like.dart
    │   │   │   │   ├── media.dart
    │   │   │   │   ├── pageable.dart
    │   │   │   │   ├── post.dart
    │   │   │   │   └── sort.dart
    │   │   │   ├── role.dart
    │   │   │   ├── search.dart
    │   │   │   └── tracking.dart
    │   │   ├── request
    │   │   │   ├── token_request.dart
    │   │   │   └── user_request.dart
    │   │   └── response
    │   │   │   ├── admin_res.dart
    │   │   │   ├── error_res.dart
    │   │   │   ├── image_res.dart
    │   │   │   ├── notification_res.dart
    │   │   │   ├── token_res.dart
    │   │   │   └── user_res.dart
    │   └── repository
    │   │   ├── auth_repo.dart
    │   │   ├── notification_repo.dart
    │   │   ├── post_repo.dart
    │   │   ├── search_repo.dart
    │   │   ├── tracking_repo.dart
    │   │   ├── upload_file_repo.dart
    │   │   └── user_repo.dart
    ├── firebase_options.dart
    ├── helper
    │   ├── date_converter_hepler.dart
    │   ├── loading_helper.dart
    │   ├── notification_helper.dart
    │   ├── route_helper.dart
    │   └── validation_helper.dart
    ├── main.dart
    ├── message.dart
    ├── screens
    │   ├── home_admin
    │   │   └── home_admin_screen.dart
    │   ├── home_user
    │   │   └── home_user_screen.dart
    │   ├── info_user
    │   │   └── info_user_screen.dart
    │   ├── list_user
    │   │   ├── detail_user_screen.dart
    │   │   ├── list_user_screen.dart
    │   │   └── widget
    │   │   │   └── list_user_item.dart
    │   ├── notification
    │   │   ├── notification_screen.dart
    │   │   └── widgets
    │   │   │   └── notification_item.dart
    │   ├── person
    │   │   └── person_screen.dart
    │   ├── post
    │   │   ├── add_post_screen.dart
    │   │   ├── post_comment.dart
    │   │   ├── post_screen.dart
    │   │   └── widget
    │   │   │   ├── button_add_post_widget.dart
    │   │   │   ├── button_animated.dart
    │   │   │   └── post_item.dart
    │   ├── sign_in
    │   │   └── sign_in_screen.dart
    │   ├── sign_up
    │   │   ├── enter_info_screen.dart
    │   │   └── sign_up_screen.dart
    │   ├── splash
    │   │   └── splash_screen.dart
    │   ├── tracking
    │   │   ├── tracking_screen.dart
    │   │   └── widgets
    │   │   │   ├── button__tracking_widget.dart
    │   │   │   └── tracking_item.dart
    │   └── widgets
    │   │   ├── button_drawer_widget.dart
    │   │   ├── button_primary_widget.dart
    │   │   ├── dialog_widget.dart
    │   │   ├── drawer_widget.dart
    │   │   ├── dropdown_language_widget.dart
    │   │   ├── switch_widget.dart
    │   │   └── text_field_widget.dart
    ├── services
    │   ├── firebase_service.dart
    │   └── language_service.dart
    ├── theme
    │   ├── dark_theme.dart
    │   ├── light_theme.dart
    │   └── theme_controller.dart
    ├── utils
    │   ├── app_constant.dart
    │   ├── asset_util.dart
    │   ├── color_resources.dart
    │   ├── dimensions.dart
    │   ├── language
    │   │   ├── key_language.dart
    │   │   ├── st_en_us.dart
    │   │   └── st_vi_vn.dart
    │   └── styles.dart
    └── views
    │   ├── custom_dialog_calendar.dart
    │   ├── custom_loading.dart
    │   └── custom_snackbar.dart

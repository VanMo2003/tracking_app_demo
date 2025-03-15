├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── android
    ├── .gitignore
    ├── app
    │   ├── build.gradle
    │   ├── google-services.json
    │   └── src
    │   │   ├── debug
    │   │       └── AndroidManifest.xml
    │   │   ├── main
    │   │       ├── AndroidManifest.xml
    │   │       ├── kotlin
    │   │       │   └── com
    │   │       │   │   └── example
    │   │       │   │       └── tracking_app_demo
    │   │       │   │           └── MainActivity.kt
    │   │       └── res
    │   │       │   ├── drawable-v21
    │   │       │       └── launch_background.xml
    │   │       │   ├── drawable
    │   │       │       └── launch_background.xml
    │   │       │   ├── mipmap-hdpi
    │   │       │       └── ic_launcher.png
    │   │       │   ├── mipmap-mdpi
    │   │       │       └── ic_launcher.png
    │   │       │   ├── mipmap-xhdpi
    │   │       │       └── ic_launcher.png
    │   │       │   ├── mipmap-xxhdpi
    │   │       │       └── ic_launcher.png
    │   │       │   ├── mipmap-xxxhdpi
    │   │       │       └── ic_launcher.png
    │   │       │   ├── values-night
    │   │       │       └── styles.xml
    │   │       │   └── values
    │   │       │       └── styles.xml
    │   │   └── profile
    │   │       └── AndroidManifest.xml
    ├── build.gradle
    ├── gradle.properties
    ├── gradle
    │   └── wrapper
    │   │   └── gradle-wrapper.properties
    └── settings.gradle
├── assets
    ├── font
    │   ├── Lato Hairline.ttf
    │   ├── Lato Heavy.ttf
    │   ├── Lato Italic.ttf
    │   ├── Lato Light.ttf
    │   ├── LatoBold.ttf
    │   ├── LatoMedium.ttf
    │   ├── LatoRegular.ttf
    │   ├── Lato_Black.ttf
    │   ├── Lato_Semibold.ttf
    │   └── Lato_Thin.ttf
    ├── icons
    │   ├── attendance.png
    │   ├── back.png
    │   ├── back_bottom.png
    │   ├── dark.png
    │   ├── image.png
    │   ├── list.png
    │   ├── no_internet.png
    │   ├── person.png
    │   ├── tracking.png
    │   └── tracking_logo.png
    └── images
    │   ├── avatar.jpeg
    │   ├── avatar.png
    │   ├── background.jpg
    │   ├── background_drawer.jpg
    │   ├── background_login.jpg
    │   └── background_post.webp
├── devtools_options.yaml
├── firebase.json
├── ios
    ├── .gitignore
    ├── Flutter
    │   ├── AppFrameworkInfo.plist
    │   ├── Debug.xcconfig
    │   └── Release.xcconfig
    ├── Runner.xcodeproj
    │   ├── project.pbxproj
    │   ├── project.xcworkspace
    │   │   ├── contents.xcworkspacedata
    │   │   └── xcshareddata
    │   │   │   ├── IDEWorkspaceChecks.plist
    │   │   │   └── WorkspaceSettings.xcsettings
    │   └── xcshareddata
    │   │   └── xcschemes
    │   │       └── Runner.xcscheme
    ├── Runner.xcworkspace
    │   ├── contents.xcworkspacedata
    │   └── xcshareddata
    │   │   ├── IDEWorkspaceChecks.plist
    │   │   └── WorkspaceSettings.xcsettings
    ├── Runner
    │   ├── AppDelegate.swift
    │   ├── Assets.xcassets
    │   │   ├── AppIcon.appiconset
    │   │   │   ├── Contents.json
    │   │   │   ├── Icon-App-1024x1024@1x.png
    │   │   │   ├── Icon-App-20x20@1x.png
    │   │   │   ├── Icon-App-20x20@2x.png
    │   │   │   ├── Icon-App-20x20@3x.png
    │   │   │   ├── Icon-App-29x29@1x.png
    │   │   │   ├── Icon-App-29x29@2x.png
    │   │   │   ├── Icon-App-29x29@3x.png
    │   │   │   ├── Icon-App-40x40@1x.png
    │   │   │   ├── Icon-App-40x40@2x.png
    │   │   │   ├── Icon-App-40x40@3x.png
    │   │   │   ├── Icon-App-60x60@2x.png
    │   │   │   ├── Icon-App-60x60@3x.png
    │   │   │   ├── Icon-App-76x76@1x.png
    │   │   │   ├── Icon-App-76x76@2x.png
    │   │   │   └── Icon-App-83.5x83.5@2x.png
    │   │   └── LaunchImage.imageset
    │   │   │   ├── Contents.json
    │   │   │   ├── LaunchImage.png
    │   │   │   ├── LaunchImage@2x.png
    │   │   │   ├── LaunchImage@3x.png
    │   │   │   └── README.md
    │   ├── Base.lproj
    │   │   ├── LaunchScreen.storyboard
    │   │   └── Main.storyboard
    │   ├── Info.plist
    │   └── Runner-Bridging-Header.h
    └── RunnerTests
    │   └── RunnerTests.swift
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
├── linux
    ├── .gitignore
    ├── CMakeLists.txt
    ├── flutter
    │   ├── CMakeLists.txt
    │   ├── generated_plugin_registrant.cc
    │   ├── generated_plugin_registrant.h
    │   └── generated_plugins.cmake
    ├── main.cc
    ├── my_application.cc
    └── my_application.h
├── macos
    ├── .gitignore
    ├── Flutter
    │   ├── Flutter-Debug.xcconfig
    │   ├── Flutter-Release.xcconfig
    │   └── GeneratedPluginRegistrant.swift
    ├── Runner.xcodeproj
    │   ├── project.pbxproj
    │   ├── project.xcworkspace
    │   │   └── xcshareddata
    │   │   │   └── IDEWorkspaceChecks.plist
    │   └── xcshareddata
    │   │   └── xcschemes
    │   │       └── Runner.xcscheme
    ├── Runner.xcworkspace
    │   ├── contents.xcworkspacedata
    │   └── xcshareddata
    │   │   └── IDEWorkspaceChecks.plist
    ├── Runner
    │   ├── AppDelegate.swift
    │   ├── Assets.xcassets
    │   │   └── AppIcon.appiconset
    │   │   │   ├── Contents.json
    │   │   │   ├── app_icon_1024.png
    │   │   │   ├── app_icon_128.png
    │   │   │   ├── app_icon_16.png
    │   │   │   ├── app_icon_256.png
    │   │   │   ├── app_icon_32.png
    │   │   │   ├── app_icon_512.png
    │   │   │   └── app_icon_64.png
    │   ├── Base.lproj
    │   │   └── MainMenu.xib
    │   ├── Configs
    │   │   ├── AppInfo.xcconfig
    │   │   ├── Debug.xcconfig
    │   │   ├── Release.xcconfig
    │   │   └── Warnings.xcconfig
    │   ├── DebugProfile.entitlements
    │   ├── Info.plist
    │   ├── MainFlutterWindow.swift
    │   └── Release.entitlements
    └── RunnerTests
    │   └── RunnerTests.swift
├── pubspec.lock
├── pubspec.yaml
├── test
    └── widget_test.dart
├── web
    ├── favicon.png
    ├── icons
    │   ├── Icon-192.png
    │   ├── Icon-512.png
    │   ├── Icon-maskable-192.png
    │   └── Icon-maskable-512.png
    ├── index.html
    └── manifest.json
└── windows
    ├── .gitignore
    ├── CMakeLists.txt
    ├── flutter
        ├── CMakeLists.txt
        ├── generated_plugin_registrant.cc
        ├── generated_plugin_registrant.h
        └── generated_plugins.cmake
    └── runner
        ├── CMakeLists.txt
        ├── Runner.rc
        ├── flutter_window.cpp
        ├── flutter_window.h
        ├── main.cpp
        ├── resource.h
        ├── resources
            └── app_icon.ico
        ├── runner.exe.manifest
        ├── utils.cpp
        ├── utils.h
        ├── win32_window.cpp
        └── win32_window.h

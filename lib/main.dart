import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '/app_binding.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '/controllers/langue_controller.dart';
import '/helper/route_helper.dart';
import '/services/language_service.dart';
import 'firebase_options.dart';
import 'helper/notification_helper.dart';
import 'theme/theme_controller.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/app_constant.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (GetPlatform.isMobile) {
    HttpOverrides.global = MyHttpOverrides();
  }


  try {
    if (GetPlatform.isMobile) {
      await NotificationHelper.init();
      await NotificationHelper.initialize();
    }
  } catch (e) {
    throw Exception(e.toString());
  }

  await dotenv.load();
  await binding();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LanguageController>(
          builder: (languageController) {
            FlutterNativeSplash.remove();
            return GetMaterialApp(
              enableLog: true,
              debugShowCheckedModeBanner: false,
              title: AppConstant.APP_NAME,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark() : light(),
              themeMode: ThemeMode.system,
              locale: LanguageService.locale,
              fallbackLocale: LanguageService.fallbackLocale,
              translations: LanguageService(),
              initialRoute: RouteHelper.getSplashRoute(),
              getPages: RouteHelper.routes,
              defaultTransition: Transition.leftToRight,
              transitionDuration: const Duration(milliseconds: 200),
            );
          },
        );
      },
    );
  }
}

/// hàm callback được cung cấp luôn trả về true,
/// thực sự bỏ qua mọi lỗi xác thực chứng chỉ.
/// Điều này thường được sử dụng trong quá trình phát triển để cho phép kết nối với các máy chủ có chứng chỉ tự ký,
/// vốn không được tin cậy mặc định vì lý do bảo mật
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

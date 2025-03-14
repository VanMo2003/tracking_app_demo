import 'package:tracking_app_demo/screens/notification/notification_screen.dart';

import '../screens/home_admin/home_admin_screen.dart';
import '../screens/info_user/info_user_screen.dart';
import '../screens/home_user/home_user_screen.dart';
import '../screens/post/add_post_screen.dart';
import '../screens/post/post_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../screens/sign_up/sign_up_screen.dart';

import '../message.dart';
import '../screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String enterInfo = "/enter-info";
  static const String homeUser = "/home";
  static const String homeAdmin = "/home-admin";
  static const String infoUser = "/info-user";
  static const String changePassword = "/change-password";
  static const String notification = "/notification";
  static const String post = "/post";
  static const String addPost = "/add_post";
  static const String message = "/message";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getEnterInfo(String username, String password) => enterInfo;
  static String getHomeUserRoute() => homeUser;
  static String getHomeAdminRoute() => homeAdmin;
  static String getInfoUserRoute() => infoUser;
  static String getChangePassword() => changePassword;
  static String getNotificationRoute() => notification;
  static String getPostRoute({String? userId, String? displayName}) =>
      "$post?userId=${userId ?? ""}&displayName=${displayName ?? ""}";
  static String getAddPostRoute() => addPost;
  static String getMessage() => message;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: homeUser, page: () => const HomeUserScreen()),
    GetPage(name: homeAdmin, page: () => const HomeAdminScreen()),
    GetPage(name: infoUser, page: () => const InfoUserScreen()),
    GetPage(name: post, page: () => const PostScreen()),
    GetPage(name: addPost, page: () => const AddPostScreen()),
    GetPage(name: message, page: () => const MessageScreent()),
    GetPage(name: notification, page: () => const NotificationScreen()),
  ];
}

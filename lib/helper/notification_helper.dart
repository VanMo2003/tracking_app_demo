import 'dart:convert';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';
import 'package:tracking_app_demo/controllers/notification_controller.dart';
import 'package:tracking_app_demo/controllers/user_controller.dart';
import 'package:tracking_app_demo/utils/app_constant.dart';
import 'package:tracking_app_demo/views/custom_snackbar.dart';
import '/helper/route_helper.dart';
import '/services/firebase_service.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;


class NotificationHelper {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final _analytics = FirebaseAnalytics.instance;
  static final onClickNotification = BehaviorSubject<String>();
  static late String serverAccessTokenKey;

  // ontap local notification foreground
  static void onNotification(NotificationResponse notificationResponse) {
    Get.toNamed(RouteHelper.getNotificationRoute(), arguments: notificationResponse);
  }

  // ontap local notification background
  static Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      debugPrint('some notification Received in Background');
    }
  }

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    await getAccessToken();

    // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

    FirebaseMessaging.onMessage.listen(
          (message) {
        String payloadData = jsonEncode(message.data);
        if (message.notification != null) {
          Get.find<NotificationController>().testPush().then(
            (value) {
              if(value == 200){
                NotificationHelper.showSimpleNotification(
                  title: message.notification!.title!,
                  body: message.notification!.body!,
                  payload: payloadData,
                );
              }else{
                showCustomSnackBar("Gửi thông báo thất bại");
              }
            },
          );
         
        }
      },
    );

    // Xử lý khi người dùng nhấn vào thông báo khi ứng dụng ở chế độ background
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        debugPrint('to message : $message');
        Get.toNamed(RouteHelper.getNotificationRoute(), arguments: message);
      },
    );

    // xử lý khi app đóng hoàn toàn
    final RemoteMessage? message =
    await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      debugPrint('launched from terminated state');
      Future.delayed(
        const Duration(seconds: 1),
            () {
          Get.toNamed(RouteHelper.getNotificationRoute(), arguments: message);
        },
      );
    }
  }

  static Future getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    log('device token : $token');
    if (Get.find<UserController>().user != null) {
      await FirebaseService.saveUserToken(token!);
      log('save to firestore');
    }


    // also save if token changes
    _firebaseMessaging.onTokenRefresh.listen(
      (event) async {
        if (Get.find<UserController>().user != null) {
          await FirebaseService.saveUserToken(token!);
          log('save to firestore');
        }
      },
    );
  }

  static Future<String> getAccessToken() async {
    final serviceAccountJson =
    {
      "type": dotenv.env['type'],
      "project_id": dotenv.env['project_id'],
      "private_key_id": dotenv.env['private_key_id'],
      "private_key": dotenv.env['private_key'],
      "client_email": dotenv.env['client_email'],
      "client_id": dotenv.env['client_id'],
      "auth_uri": dotenv.env['auth_uri'],
      "token_uri": dotenv.env['token_uri'],
      "auth_provider_x509_cert_url": dotenv.env['auth_provider_x509_cert_url'],
      "client_x509_cert_url": dotenv.env['client_x509_cert_url'],
      "universe_domain": dotenv.env['universe_domain']
    };
      List<String> scopes = [
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/firebase.database",
        "https://www.googleapis.com/auth/firebase.messaging"
      ];

      http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes
      );

      // get the access token
      auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client
      );

      client.close();
      serverAccessTokenKey = credentials.accessToken.data;

      return serverAccessTokenKey;
  }

  static Future<void> initialize() async {
    var androidInitialize =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    var iosInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    // request notification permission for android 13 or above
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: onNotification,
      onDidReceiveBackgroundNotificationResponse: onNotification,
    );
  }

  // show a simple notifications
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "tracking-app",
      "tracking-app-demo",
      channelDescription: "this is application tracking",
      importance: Importance.max,
      priority: Priority.high,
      ticker: "ticker",
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future<int> sendMessage() async {
    final tokenDevice = await _firebaseMessaging.getToken();
    debugPrint("tokenDevice $tokenDevice");
    Map<String, String> headers = {
      "Authorization" : "Bearer $serverAccessTokenKey",
      "content-type": "application/json"
    };
    Map<String, dynamic> body = {
      "message":{
        "token" : tokenDevice,
        "notification": {
          "title": "Xin chào!",
          "body": "Đây là một thông báo thử nghiệm"
        }
      }
    };

    http.Response response = await http.post(
        Uri.parse(AppConstant.NOTIFICATION_URL),
        headers: headers,
        body:jsonEncode(body)
    );

    return response.statusCode;
  }



}

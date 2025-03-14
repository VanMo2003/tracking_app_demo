class AppConstant {
  static const String APP_NAME = "Tracking App";

  static const String BASE_URL = 'http://android-tracking.oceantech.com.vn/mita';
  static const String NOTIFICATION_URL = 'https://fcm.googleapis.com/v1/projects/test-notification-af33b/messages:send';

  static const String LOGIN_URI = '/oauth/token';
  static const String REGISTOR_URI = '/public/sign';
  static const String GET_USER = '/users/get-user-current';
  static const String LOG_OUT = '/oauth/logout';
  static const String LOCK = '/users/lock';
  static const String UPDATE_MYSELF = '/users/update-myself';
  static const String UPDATE_USER = '/users/update';
  static const String TRACKING = '/tracking';
  static const String GET_ALL_USER = '/users/searchByPage';
  static const String CHECK_IN = '/time-sheets/check-in';
  static const String POSTS = '/posts/get-news';
  static const String POSTS_BY_USER = '/posts/get-news-by-user';
  static const String ADD_POST = '/posts/create';
  static const String LIKE_POST = '/posts/likes';
  static const String COMMENT_POST = '/posts/comments';
  static const String UPLOAD_FILE = '/public/uploadFile';
  static const String GET_FILE_BY_NAME = '/public/images';
  static const String TEST_PUSH = '/notifications/test-push';
  static const String GET_ALL_NOTIFICATION_BY_USER = '/notifications';

  static const String URL_GET_IMAGE = BASE_URL + GET_FILE_BY_NAME + "/";

  static const String LANGUAGE_CODE = '6ammart_language_code';
  static const String TOKEN = '6ammart_token';
  static const String THEME = '6ammart_theme';

  static const String LOCALIZATION_KEY = 'X-localization';
  static const String MODULE_ID = 'moduleId';

  static const List<String> birthPlaces = [
    "Hà Giang",
    "Cao Bằng",
    "Lào Cai",
    "Sơn La",
    "Lai Châu",
    "Bắc Kạn",
    "Lạng Sơn",
    "Tuyên Quang",
    "Yên Bái",
    "Thái Nguyên",
    "Điện Biên",
    "Phú Thọ",
    "Vĩnh Phúc",
    "Bắc Giang",
    "Bắc Ninh",
    "Hà Nội",
    "Quảng Ninh",
    "Hải Dương",
    "Hải Phòng",
    "Hòa Bình",
    "Hưng Yên",
    "Hà Nam",
    "Thái Bình",
    "Nam Định",
    "Ninh Bình",
    "Thanh Hóa",
    "Nghệ An",
    "Hà Tĩnh",
    "Quảng Bình",
    "Quảng Trị",
    "Thừa Thiên Huế",
    "Đà Nẵng",
    "Quảng Nam",
    "Quảng Ngãi",
    "Kon Tum",
    "Gia Lai",
    "Bình Định",
    "Phú Yên",
    "Đắk Lắk",
    "Khánh Hòa",
    "Đắk Nông",
    "Lâm Đồng",
    "Ninh Thuận",
    "Bình Phước",
    "Tây Ninh",
    "Bình Dương",
    "Đồng Nai",
    "Bình Thuận",
    "Thành phố Hồ Chí Minh",
    "Long An",
    "Bà Rịa–Vũng Tàu",
    "Đồng Tháp",
    "An Giang",
    "Tiền Giang",
    "Vĩnh Long",
    "Bến Tre",
    "Cần Thơ",
    "Kiên Giang",
    "Trà Vinh",
    "Hậu Giang",
    "Sóc Trăng",
    "Bạc Liêu",
    "Cà Mau"
  ];
}

class ApiLinks {
  static String login = "api/TokenAuth/Authenticate";
  static String logout = "api/services/app/Account/Logout";

  static String register = "api/services/app/Account/RegisterMob";

  static String fcmNotification =
      "api/services/app/FcmNotification/GetMobileAll";
  static String fcmNotificationRead = "api/services/app/FcmNotification/Read";
  static String getHomePage = "api/services/app/Home/Get";

  static String getCategories = "api/services/app/Category/GetAll";

  static String getAllCategoryNews = "api/services/app/CategoryNews/GetAll";
  static String getAllNewsByCategoryIdById =
      "api/services/app/CategoryNews/GetByCategoryId";

  static String getNewsById = "api/services/app/CategoryNews/GetById";
  // static String getAllGifts = "services/app/Gift/GetAll";
  // static String getGiftById = "services/app/Gift/GetById";

  static String getAllLevel = "api/services/app/Level/GetAll";

  static String getAllProduct = "api/services/app/Product/GetProducts";
  static String getProductById = "api/services/app/Product/GetById";

  static String getProfile = "api/services/app/User/GetProfile";
  static String complaint = "api/services/app/Complaint/Create";
  static String getGeneralSetting = "api/services/app/GeneralSetting/GetAll";
  static String readQrcode = "api/services/app/QrCode/ReadCode";

  static String createGift = "api/services/app/UserGift/Create";
}

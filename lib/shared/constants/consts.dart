class AppConstant {

  //Base Router Url
  static String BASE_URL = "http://192.168.1.38:8001/";

  //static String BASE_URL = "http://127.0.0.1:8000/";

  //AUTH
  static String REGISTER = "api/auth/worker/register";
  static String LOGIN = "api/auth/worker/login";
  static String LOGOUT_CURRENT_SESSION = "api/auth/worker/logout_current_session";
  static String LOGOUT_ALL_SESSION = "api/auth/worker/logout_all_sessions";

  //User Profile
  static String PROFILE = "api/worker/get_profile";
  static String UPDATE_PROFILE = "api/worker/update_profile";
  static String CHANGE_PASSWORD = "api/worker/change_password";
  static String DELETE_ACCOUNT = "api/worker/delete_account";


  //PROFILE IMAGE
  static String UPLOAD_PROFILE_IMAGE = "api/worker/upload_profile_image";
  static String UPDATE_PROFILE_IMAGE = "api/worker/update_profile_image";
  static String DELETE_PROFILE_IMAGE = "api/worker/delete_profile_image";

  //CATEGORY
  static String GET_CATEGORIES_NAME = "api/worker/get_categories";

  //Reviews
  static String GET_REVIEWS = "api/worker/reviews";

  //-------------------------------Assets Files---------------------------------//
  static String LOGO_WITH_TEXT_URL = "assets/images/in_app_images/app_logo.png";
  static String LOGO_WITHOUT_TEXT_URL = "assets/images/in_app_images/logo_without_text.png";
}
class UrlConstants {
  static String baseUrl = "https://app.pawasharing.com/";
  static final String checkLogin = "${baseUrl}api/check-email";
  static final String register = "${baseUrl}api/user/create";
  static final String socialLogin = "${baseUrl}api/social/login";
  static final String login = "${baseUrl}api/user/login";
  static final String logout = "${baseUrl}api/user/logout";
  static final String getAllStations = "${baseUrl}api/get-all-stations";
  static final String powerBankRequest = "${baseUrl}api/powerbank-request";
  static final String getUserInfo = "${baseUrl}api/my-profile";
  static final String updateProfile = "${baseUrl}api/update-profile";
  static final String reportProblem = "${baseUrl}api/report-an-issue";
  static final String rentalActivity = "${baseUrl}api/get-rental-activities";
  static final String getWallet = "${baseUrl}api/user/wallet";
  static final String search = "${baseUrl}api/search-stations";
  static final String deleteAccount = "${baseUrl}api/account/suspend";
  static final String getSubscription = "${baseUrl}api/get-subscription-plans";
  static final String setSubScription = "${baseUrl}api/subscribe";
  static final String getReferalCode = "${baseUrl}api/user/apply-referral-code";
  static final String activateReferalCode = "${baseUrl}api/user/apply-referral-code";
}

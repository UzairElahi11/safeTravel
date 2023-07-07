class UserDataManager {
  static UserDataManager? _instance;
  static UserDataManager getInstance() {
    _instance ??= UserDataManager._();
    return _instance!;
  }

  UserDataManager._() {
    setDrawerKey();
  }

  void setDrawerKey() {}
  String fcmToken = "";
  String deviceType = "";
  String lat = "";
  String long = "";
}

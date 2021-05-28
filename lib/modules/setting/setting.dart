class Setting {
  static final Setting _instance = Setting._internal();

  // DEFAULT SETTING
  static int requestItemPerPage = 10;

  factory Setting() {
    return _instance;
  }

  Setting._internal() {
     // Init properties here
  }

}
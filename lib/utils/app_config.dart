class AppConfig {
  static String getBaseUrl() {
    // return "https://192.168.20.241:44379/";
    return "http://192.168.20.241/ABXBookingAPI/";
    // return "http://192.168.0.166/ABXBookingAPI/";
  }

  static int connectTimeout() {
    return 100000;
  }

  static int receiveTimeout() {
    return 150000;
  }

  static int sendTimeout() {
    return 150000;
  }
}

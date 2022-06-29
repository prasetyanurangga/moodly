import 'dart:html';

class CookieManager {

  void addToCookie(String key, String value, String other) {
    document.cookie = "$key=$value;$other;";
  }

  String getCookie(String key) {

    String? cookies = document.cookie ?? "";
    List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : <String>[];
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        matchVal = _val;
        break;
      }
    }
    return matchVal;
  }

  bool containCookie(String key) {

    String? cookies = document.cookie ?? "";
    List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : <String>[];
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        return true;
      }
    }
    return false;
  }
}
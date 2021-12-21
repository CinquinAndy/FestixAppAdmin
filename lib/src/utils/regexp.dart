class RegexpTokens{
  static RegExp regExpXsrf = RegExp(r"XSRF-TOKEN=(.*?);");
  static RegExp regExpBearer = RegExp(r"COOKIE-BEARER=(.*?);");
  static RegExp regExpTokenFromCookie = RegExp(r"(?:=)(.*?);");

  static String getCompleteBearer(String value){
    value = regExpBearer.stringMatch(value).toString()+" Path=/; HttpOnly; Domain=192.168.1.128";
    return value;
  }
  static String getCompleteXsrf(String value){
    value = regExpXsrf.stringMatch(value).toString()+ " Path=/; Domain=192.168.1.128";
    return value;
  }

  static String getExtractedTokenFromCookie(String value){
    final match = regExpTokenFromCookie.firstMatch(value);
    final matchedText = match?.group(1);
    value = matchedText ?? "";
    return value;
  }

}

import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class UserInfo with JsonConvert<UserInfo> {
  bool admin = false;
  String email = "";
  String icon = "";
  int id = 0;
  String nickname = "";
  String password = "";
  String publicName = "";
  String token = "";
  int type = 0;
  String username = "";
  List<int> collectIds = <int>[];
  List<dynamic> chapterTops = <dynamic>[];
}
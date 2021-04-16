import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class Banner with JsonConvert<Banner> {
  String desc = "";
  int id = 0;
  String imagePath = "";
  int isVisible = 0;
  int order = 0;
  String title = "";
  int type = 0;
  String url = "";
}
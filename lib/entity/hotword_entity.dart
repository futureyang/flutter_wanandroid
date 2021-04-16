import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class HotWord with JsonConvert<HotWord> {
  int id = 0;
  String link  = "";
  int order = 0;
  String name  = "";
  int visible = 0;
}